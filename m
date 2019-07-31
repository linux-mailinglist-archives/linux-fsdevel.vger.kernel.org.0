Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1C7BBC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGaIgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 04:36:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65132 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfGaIgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:36:04 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V8Z3LC029862;
        Wed, 31 Jul 2019 01:35:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rEBx1rFqatpPnIi7wFu4JyKUXdoKY69V5OVz1LDCa7U=;
 b=O9P7JnXU1Yje1KTdyg7+Eu++6zYl84ZsZS1WcCJWL6xcDTsvUUZ/hUkLNs4NjiKLh3UN
 qaReqYIAYcx/ac9tOu101SlSNu19w1ff5RRhh2gUKZKjK/cpC5giFF7IqFX7Y2K8s6Mn
 cfYiUR4LWkTWR9kG7QSKA69wvCFTIm8I3Dk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u2p9hkk4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 01:35:49 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 31 Jul 2019 01:35:47 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 01:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB60CEhEK2D8/ru8ig/WW0suIcutxT56ekdHQVHyAM0+P2WwuhZXxV1BUvCkKKYfqTQsV3+jx5SvKQm+x9igl6wBmm/OKPQCLpMpR8jEW5IFnTU/xNdQ1NBp3dPceGP7v7KFx+KTSIxwjlvUooosD+9fosTXYTx+hZ0iV6qW8+UEpHw/lZqIUjV7urokAEIgh1iAtSZRd0NzJhvfIGbFRpQ5tqhLNGxyY+yvF3hIIPyhNlPaMV0FFO4jocY/4ULwXEg6ZQKCf3+CH8SETIMvyaDS4jDhnXhoMuQOIRPk+cNsmYELrbHZIY0pT53TN7pBIqVJqD61+NezUNVAeZnPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEBx1rFqatpPnIi7wFu4JyKUXdoKY69V5OVz1LDCa7U=;
 b=Tn/7MxPXCo9c0WN9rI+jPVa9uGOTxpNx7RS83eP5pp3Vm4yMZCgcftZQynxHVAuEDVHj9P/+niQNUbffU5t6AzrUFzMuunXKRvqYSclAs1DJJy+ALCJyULK73kEfAOOfQ90kbyXTj+l5PAo3/W1ai58v4mVeIf14i0HFmomAoSnHXDVmR0UrcpgwJwx8H50ShVXPvnT2V62fkoMZ5vQo/+3kGdiMEbf8kD7/CFg8G4f/n2o2q18WI8hxnDh4HvXtTrhOh7+4m5zeoxLnMlOxSihyP+mWWsriBVn4zgpEiKO61/lLKP5pbL+Lq5+ZvT64cls7DdXFA9fup5ikord5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEBx1rFqatpPnIi7wFu4JyKUXdoKY69V5OVz1LDCa7U=;
 b=EA+stxHQXI/La1VYj1N1Z4P6/QPq9TlxtMW7r7+vwk9VV62fHqt1VaMrtLDTpD88YrXwonRBE+8vo8Na1cmsAWz4tEELaQ8iMqGVXZgsmXH2FIiMajsqVJ2zWd8Dd6REacIyOOC3rsBcepvyT9WBZvo+zJ9mQdm8eQFCMmoVoOY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1312.namprd15.prod.outlook.com (10.175.4.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 31 Jul 2019 08:35:47 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 08:35:47 +0000
From:   Song Liu <songliubraving@fb.com>
To:     William Kucharski <william.kucharski@oracle.com>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
Thread-Topic: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
Thread-Index: AQHVR3mCOKwnV56WUUyluRdig0XL86bkZvIA
Date:   Wed, 31 Jul 2019 08:35:46 +0000
Message-ID: <C9405E2A-4A0B-4EFD-B432-C54D2C9CFC2B@fb.com>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
In-Reply-To: <20190731082513.16957-1-william.kucharski@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:6d8b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63204fcb-963d-4141-b478-08d7159215bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1312;
x-ms-traffictypediagnostic: MWHPR15MB1312:
x-microsoft-antispam-prvs: <MWHPR15MB13122F142A54089CC65B24AEB3DF0@MWHPR15MB1312.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(305945005)(57306001)(50226002)(54906003)(8936002)(446003)(102836004)(2616005)(486006)(186003)(71190400001)(66556008)(64756008)(476003)(5660300002)(478600001)(6506007)(81156014)(66476007)(229853002)(6486002)(76176011)(68736007)(46003)(76116006)(36756003)(53546011)(66446008)(6916009)(4326008)(11346002)(66946007)(6116002)(14454004)(33656002)(256004)(81166006)(53936002)(6246003)(25786009)(8676002)(71200400001)(99286004)(6512007)(7416002)(316002)(6436002)(2906002)(7736002)(86362001)(142933001)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1312;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lZAkvh2sNC1fzKIaVom/N0TJGn2sn7KEJwVOMM2SS3IozJgmhQ9XR83aIGn7IpM6sL78d8BkO+IF5mISw/XPLJB6Mlm7TKSI2d/evRF2pi8S6tQRkW1rFiy93zs/o0r4Ecx1rRKriurH6Uhsg54C0kaeHZI4/D0NGVP7KV+52ZHuY5XWpiqEKYwoUV6GZdX7/at87BFAWqCKY3IMqDbObAoqli0+Xqs9d6cRHRJ7b1YLHYjIpI+pnrbLD1oTbulDW63tmCMdQpj/AyFUUQDp7B4851KVyi94YDKSIZZSjqtkXRkhBNYufC2BUFizuzSEVFDgKCjn75dpvNEN0izwqannkxojKbeSZU2XmkYVwQbNDRzRme/wKumDl8i1LeeNRr4v8GxtwOaWhLcsxzEYs1PWoS1NA1PmzR3ajQtiL5M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E2A26E3179D714EACC580A7A1618AB3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63204fcb-963d-4141-b478-08d7159215bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 08:35:46.7934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1312
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310092
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 31, 2019, at 1:25 AM, William Kucharski <william.kucharski@oracle.=
com> wrote:
>=20
> This set of patches is the first step towards a mechanism for automatical=
ly
> mapping read-only text areas of appropriate size and alignment to THPs
> whenever possible.
>=20
> For now, the central routine, filemap_huge_fault(), amd various support
> routines are only included if the experimental kernel configuration optio=
n
>=20
> 	RO_EXEC_FILEMAP_HUGE_FAULT_THP
>=20
> is enabled.
>=20
> This is because filemap_huge_fault() is dependent upon the
> address_space_operations vector readpage() pointing to a routine that wil=
l
> read and fill an entire large page at a time without poulluting the page
> cache with PAGESIZE entries for the large page being mapped or performing
> readahead that would pollute the page cache entries for succeeding large
> pages. Unfortunately, there is no good way to determine how many bytes
> were read by readpage(). At present, if filemap_huge_fault() were to call
> a conventional readpage() routine, it would only fill the first PAGESIZE
> bytes of the large page, which is definitely NOT the desired behavior.
>=20
> However, by making the code available now it is hoped that filesystem
> maintainers who have pledged to provide such a mechanism will do so more
> rapidly.

Could you please explain how to test/try this? Would it automatically map
all executables to THPs?=20

Thanks,
Song=
