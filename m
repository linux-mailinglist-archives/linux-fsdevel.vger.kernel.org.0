Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADBC50FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfFXPGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 11:06:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbfFXPGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:06:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OEvnsO004968;
        Mon, 24 Jun 2019 08:04:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wAbXcPgUJOYdfGMLbmH1Z7DXHW0tzW6Rge5M0Y12xYg=;
 b=V+afxCw4wjdx8xnBGMl2OAvyO54pvEZYHW50MQXGa2C9fmulrZGDX/bfSl+GbizmStrI
 oEIQgRzrwALjcQ5A9HCodFDryka1CT7Bkg5JY3sazSHgWePCxzt30Dyol8e1GAxs4ggp
 SCYgv+FlpwGrSNwbgQcEyJ+1+jESJkzRER8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2taujw1545-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:04:23 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 08:04:23 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 08:04:22 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 08:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAbXcPgUJOYdfGMLbmH1Z7DXHW0tzW6Rge5M0Y12xYg=;
 b=EDPL+dC6XilxxNf4HQX2esAFi2NtG55lAVOmkvT+ojvjaaryQ/arT4Zy5P+WT78yjHGbvpuXAVKMICdraijWF/luA4wgT/6c1yDQtpG4dYO6LS1+mThdXPH/AijuUC/HMpPFlefDSI0/4+AGVXf32Gl4TQqhkHDcrn60I5bfWGo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1232.namprd15.prod.outlook.com (10.175.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:04:21 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:04:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVKYdGAmz09KUZ80Kts9GVGsmXGaaqwvwAgAAUeoCAAAd4gIAABAcAgAADi4CAAAKkAA==
Date:   Mon, 24 Jun 2019 15:04:21 +0000
Message-ID: <5BE23F34-B611-496B-9277-A09C9CC784B1@fb.com>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
 <20190624124746.7evd2hmbn3qg3tfs@box>
 <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
 <20190624142747.chy5s3nendxktm3l@box>
 <C3161C66-5044-44E6-92F4-BBAD42EDF4E2@fb.com>
 <20190624145453.u4ej3e4ktyyqjite@box>
In-Reply-To: <20190624145453.u4ej3e4ktyyqjite@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:d642]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac82330-a4bb-43fa-ae24-08d6f8b53d03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1232;
x-ms-traffictypediagnostic: MWHPR15MB1232:
x-microsoft-antispam-prvs: <MWHPR15MB1232812A54DBA94A2CDEDEC3B3E00@MWHPR15MB1232.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(68736007)(66556008)(6486002)(81156014)(54906003)(4326008)(76176011)(86362001)(36756003)(14444005)(5660300002)(25786009)(102836004)(53936002)(53546011)(14454004)(6506007)(71190400001)(6916009)(6246003)(316002)(71200400001)(478600001)(33656002)(6436002)(50226002)(8676002)(64756008)(66446008)(11346002)(66476007)(46003)(81166006)(229853002)(76116006)(66946007)(99286004)(6512007)(8936002)(186003)(486006)(73956011)(476003)(305945005)(256004)(7736002)(2616005)(57306001)(6116002)(2906002)(446003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1232;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tPD8t/UNAK4Vi02lbF9qIaK9bfU9bG1mrnoVdYULmwo+/Ka3TPaYRA/ag++ZagjNYIXZkp/NJ/SxARdDVqOPdHgB8DeFWTdxvRW+r5KJLKuqBLuJa2FhOxATFOAwH+gFNKN+JsLm7jeJnJYry71Za0StevZGQ9qbkvhsF6FoGMBYQ6r7N3Ap6V9HXUzyBb8qTZ98q4iSLaE9/dFI2V+H1qDnr+mpH+TSvjPNYWYiCDFwE8XLi9kktQMv3DwOHjICpC1cy5J3D9Pzq2EQ8ULjXmybI3LFnrALoHbcUpr6ZXuDL+SwWKT2ZG4WED7L89xjhLV1FhZ1AP3Gy1rDasbuAFA8EGcJlRDA/GWW2AOaeeSnuJ8R9pTk7MrWMm8QHSDOf/PUAzo/asKxTEeoLX5ucHcUH3VqUTavQP7mlUondDI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADE4CD8BAFE8BE4DA4CFF6C4D4090BC4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac82330-a4bb-43fa-ae24-08d6f8b53d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:04:21.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1232
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240122
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 24, 2019, at 7:54 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Mon, Jun 24, 2019 at 02:42:13PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Jun 24, 2019, at 7:27 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>>>=20
>>> On Mon, Jun 24, 2019 at 02:01:05PM +0000, Song Liu wrote:
>>>>>> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct *m=
m,
>>>>>> 				result =3D SCAN_FAIL;
>>>>>> 				goto xa_unlocked;
>>>>>> 			}
>>>>>> +		} else if (!page || xa_is_value(page)) {
>>>>>> +			xas_unlock_irq(&xas);
>>>>>> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
>>>>>> +						  index, PAGE_SIZE);
>>>>>> +			lru_add_drain();
>>>>>=20
>>>>> Why?
>>>>=20
>>>> isolate_lru_page() is likely to fail if we don't drain the pagevecs.=20
>>>=20
>>> Please add a comment.
>>=20
>> Will do.=20
>>=20
>>>=20
>>>>>> +			page =3D find_lock_page(mapping, index);
>>>>>> +			if (unlikely(page =3D=3D NULL)) {
>>>>>> +				result =3D SCAN_FAIL;
>>>>>> +				goto xa_unlocked;
>>>>>> +			}
>>>>>> +		} else if (!PageUptodate(page)) {
>>>>>=20
>>>>> Maybe we should try wait_on_page_locked() here before give up?
>>>>=20
>>>> Are you referring to the "if (!PageUptodate(page))" case?=20
>>>=20
>>> Yes.
>>=20
>> I think this case happens when another thread is reading the page in.=20
>> I could not think of a way to trigger this condition for testing.=20
>>=20
>> On the other hand, with current logic, we will retry the page on the=20
>> next scan, so I guess this is OK.=20
>=20
> What I meant that calling wait_on_page_locked() on !PageUptodate() page
> will likely make it up-to-date and we don't need to SCAN_FAIL the attempt=
.
>=20

Yeah, I got the point. My only concern is that I don't know how to=20
reliably trigger this case for testing. I can try to trigger it. But I=20
don't know whether it will happen easily.=20

Thanks,
Song




