Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06D44B3A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 20:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbhKIUBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 15:01:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4838 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244043AbhKIUBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:01:52 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9JiElS017452;
        Tue, 9 Nov 2021 19:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KGSLliE6eKYQ+mjoj8VlwAufRuI7Zv4EuJYZOtiicRo=;
 b=eDaJvVzHdXjilXbYthLdUXM3BtJgMnSO9/wlsEl8QkRbsZD164sH2P7gpjWR2UmDsG0v
 NIET0AXrMgBW2sD7JkyAIk/JfKaoM9cndjU6mz4vNhCA7E4P+yGKb5cw7XNdCmu9zpe0
 V0kB8EHI/3LWRbfeS0XYbWh796CbEd7c11nFCVXpwNnhSzGtD9c26DGDo/t4Bce+cdqT
 dWpMOBVcM0B5HiTlVw53Lz8UcvTM5F77T2u3r7LUHC8J3R0EwJbXah4t8beL1m23p6AK
 AJ9tVuEfOXrXg/PQIrm+0+VzG+nSM4L1VtUXjCmO8uDL9DRNC4OVjiruDgegLwfLoVzY kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh4pax8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 19:58:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9Ju21c091180;
        Tue, 9 Nov 2021 19:58:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by aserp3030.oracle.com with ESMTP id 3c5fregrxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 19:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHX9gB4Bh0FK9t9gLpHJCZmhFw5VtiKRsIX/P36KR+JU4j4pp4bSpc1HeGIh6PRz5BHFIILHwv0wyN8rKrjuiOaUD0GYQgEWUQMWMBKKKxHNIhbZHz084+knpxpkbrk7EGQiqWqZa7a3Gri0+KhGR75fHo9wwzkPbGUlUMEOFYGroyXMkIjLCVczdNZsy8pq1W514x33PtuJj0symSIXNjB2bQih1H8q8h7XTOjxMQ6Se7GJlOtpwwYh2nt962S81gcHT9Yw8RK95BqpQE3xcbOtkhgrMsk3NehyxRYp9QvAY1BJMTYEfaDEe5OPM9JkjF+8woALkEKfdNro31KYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGSLliE6eKYQ+mjoj8VlwAufRuI7Zv4EuJYZOtiicRo=;
 b=m1+yl0Cla3CeTs+GzgxmN2xi2Z6FweAlzhnEXd5R/sU33XDogtg06h/zvZv+b8yBmPDN0wueE0oALtCjtiiJK4XtpJXuzaIzzUliCrA9PPfx+dgHtsoC4282beuPQ6YTQDg/ImRIHTwK/gDVtABYmCDQ1/Cx2tevqNKLcTb+1b/MAuIan+BUlkgROGTeF0tgpDdbt5FFR/VJ5CvZCPmS3VcDRkwnbaijPfKPMbzAbdbIz8XbtNibVtw1TH3+mdABpUflLkHBn1erF0nhcF9tQPTJWbKzrUAvxA2n/igYs2vZYDV/MHjjLtNuAFHKN5TNF3UaGR5eyfnBlKuyHkiNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGSLliE6eKYQ+mjoj8VlwAufRuI7Zv4EuJYZOtiicRo=;
 b=maBGC19xS7fIeeYLguPPGxBp1jp2tprSoXYdLq4+oELux25fLExSwaw2VYPuvsvws9s/Ryc48GmT2VqE67EAs8zIzcFIU16WEU4vxH1E2EO3jhxA3YkEFscEd3Rq1aLnKfFo0MQXniIGht4iDM5eA6SAF5thBsR9arfW7Lav00M=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2488.namprd10.prod.outlook.com (2603:10b6:a02:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Tue, 9 Nov
 2021 19:58:48 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 19:58:48 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Topic: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Index: AQHX0qwHA1irfgJJPUKt0/SD8Ofb86v60R0AgAC+aoCAABOLAA==
Date:   Tue, 9 Nov 2021 19:58:48 +0000
Message-ID: <15f01d51-2611-3566-0d08-bdfbec53f88c@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
 <YYoi2JiwTtmxONvB@infradead.org>
 <CAPcyv4hQrUEhDOK-Ys1_=Sxb8f+GJZvpKZHTUPKQvVMaMe8XMg@mail.gmail.com>
In-Reply-To: <CAPcyv4hQrUEhDOK-Ys1_=Sxb8f+GJZvpKZHTUPKQvVMaMe8XMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 766ab48f-00c7-45aa-570b-08d9a3bb5879
x-ms-traffictypediagnostic: BYAPR10MB2488:
x-microsoft-antispam-prvs: <BYAPR10MB2488B68F64A84D5595DE5034F3929@BYAPR10MB2488.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWEameGwh0M8s0KVKPCAZL7NePCuNdut+4WEtEue9YH+9xnr+HH3mHZ4+NZ9lCirQpJftoLXgL6islWcOP8MvFlxZJkVPooeBBXHRuWrpQlXRsrd+Jso2eMk+dCtHQbZHkMjaJ1wQwNZBpf3TYL7426vdOsYzhBtyMhsfvqx0iNziAR4BfjhVuWr6jHPyIBNAvrrryNhdl3TlyoeetIXe7T2vDYFWJlFlOyX7uzOSYMrStAeppeMDIbBMQhwBr3oQRDtuxwUJFekh/UxfLfN9BzhVGHcijln3nZCReIvjQV+1h/ygyyjiTp80eAwiXON1mCNC2o4nBOcVAriIfXa43n2NXP0RRtR/U5TrGtZRC4DSbhwq0UCW2uHVKgIvrV6oD2o1xeNVBNVbDWhqCRWiP6QBTxZwDp/DpCkON21XAGPek1XPvw2rQt/Jvz26k1RxqHdvj3UvmnVDjrFTTWJK6bHE9e+oR+CflFqVAXm55VYzwR7BCNbD54bsSCW4Kh2hU82a8UZ2kKfzVcwMonvvl9736RzSWN4x8JKbom7MCk5O/1kDf5soveHvUsTynpT7YubwlcF9dmbbgo5lObyCf+qd9Bzn59VTlNO3YdVHGar7oGjNybZLQf0wj1IYQuGQ3/brTcnqcsl0sCgKomfGfysbGlvKZyz8QBc8ZKYc3ihdWRmQseu4zvT2J34/FdTTIZeSHCU9zWms9q+8/QY9TyEEn8vNvSkECOG4/Gntv1a+zymCDXYdcIeCCfRu1bJWRg/jMw8GKcm3jyTOLTNjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(71200400001)(8936002)(66946007)(66446008)(8676002)(31696002)(66556008)(316002)(64756008)(6486002)(26005)(110136005)(54906003)(86362001)(5660300002)(2906002)(66476007)(76116006)(38100700002)(6512007)(6506007)(122000001)(7416002)(31686004)(44832011)(186003)(83380400001)(2616005)(4326008)(508600001)(38070700005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVBEQnNNUFhiK1lCdnpxNjllWUp5TmpyR2VDdWZNKy85dmJkWlkyUWxheSs5?=
 =?utf-8?B?ckdJOTIzdEVXUHdta0FybXBVQjUvbDhaOE0xZEwwM0g3UVczUG11Z1lLTnJq?=
 =?utf-8?B?aEpkSUp1QUFhSG0wOXBGZEhDYXE4VzRuU3hyTFg4aUpMR2E2NlJIK1dnbE40?=
 =?utf-8?B?TEVDQ20zaUpnY3FGbkV3c3h3c1NMaXVpdnpMN3kxSE9jR0FtUmJLdUhTdnFU?=
 =?utf-8?B?U3ViRzFHSUxmL01IVEN5eXQ3OENiMTVqNGtGcitQMGNXRlNlYUxaT0piQW1R?=
 =?utf-8?B?b0djbWV2RU9WYUdMRGc4YTBmS2FtSXdObEN4MEVhQ3gvZjI4TGdKQ3kvWU5l?=
 =?utf-8?B?emtyQ094aE1qZTRJWnNiM0dzU01wa1FieGRvOGxwR0VpQVI2cGpueUFUWmtr?=
 =?utf-8?B?MVg3Nko4M2VqbEh3SUVCcHM5T1JmMWNIRHFJTjQrQjNhSnl4QnVaTmw0STNU?=
 =?utf-8?B?SVNISjFDVUNPb2hFR2FISlNkRmFxUU9vaGtIckpSSm45bUlUZ3R6UVFWZGND?=
 =?utf-8?B?NTByWlZ5YW9kNmpPTCs0eTl0QTgxUjRna2RNbEhVb3RDMXZvcHh5TkNtcm5x?=
 =?utf-8?B?aE4yT2NwaGlYbmxCNVUvenpnSjQ5RUJLaGgwRENGRlpyazR4aU1RMHVBMjlQ?=
 =?utf-8?B?eWNOT0NQdmJRaHVMVVZwT1JpMXJ6U29VaXdycXdiU1lGL0hsTm9TdURYNUl3?=
 =?utf-8?B?SHZod3BOejFSbWpyWDRjSHZhZitEOWN2Qk1wbjFNci90NGRNZUN4cTQwbkJt?=
 =?utf-8?B?Tk1haS9qMVNYT25wNDNwVVRjem90VWFLK2ZBMXpzak5LRmJDd0tmRUxLdDU3?=
 =?utf-8?B?aHdLVTZ6Z3NkQVdidC9ZMnhmZEtNUVZpOWNDS3h2L0tKb0locFFJbEs2M1hl?=
 =?utf-8?B?ZEhtbmFaMmZwaDB2b1dGUVlYSTkvYjYzWlRDbmFaK2tqVkdOQzdhS05vMzZT?=
 =?utf-8?B?RTBsY2NpTkQxM2o0RG1zcVYzOHh1dGh5dG1iZllsR0JDbDNTWTFzSm9aZG15?=
 =?utf-8?B?clhzU29GbW9JdEkxbHZ3ZU5iMERmTk5LcnQvNXpvSUZZUXduZzA5c0kvaThp?=
 =?utf-8?B?bnNjdkRVSW5RSGRLcTJONERFUmtCRDlYUmZRSmJnajRtMXFUWXNBL2hCR0hk?=
 =?utf-8?B?VTcvV1V0SFNYUGVCdVN6OXg5aDAyZ0lNYjdlbXA0cytwbXpnTEt3TGhJZW1n?=
 =?utf-8?B?U0R1MTNFS0kzZFJRZFhSUzVQN2pSMmVVUG1BaEpPOEpoRHE1UmZhLzYzaERz?=
 =?utf-8?B?Qkxab09ZbGhLa0JSQTNtVUpZdVVhczNsSnlhUWJ0RXN0NzBsNlRORVd6TGJz?=
 =?utf-8?B?djJHdjBNSXA2RmZ2YWJzTTNkQXN0azE3aDkrbURXMmtEMXFlajVONlhRNGZQ?=
 =?utf-8?B?d2dKVVJPUlFwVlU4enppQkJuZnB4MnlLLzUwN2pHTnpNcjlaR1NvbHhwQWhx?=
 =?utf-8?B?ZjZaclFxU2JnU1FkdEZ0bjhYT3dLRUo2MHdnN09sWnZhcTdWNXZ4aVpBc3kv?=
 =?utf-8?B?Y09qR3pwUEc3U1loSndFclRJYTRRMlArYTJxY1R6eU44NUI0TThOYXYxL1pV?=
 =?utf-8?B?QTAxV0ZDZVFSMnVvVWJVL1VXY1dQdGh5clM0eEs2MzlWTUVEdFBBWDNMTGFl?=
 =?utf-8?B?WisrWmxtK0VDTlowMGNxeWhvMks0bklkQkxlZmlsY1VranBLOXo3TUpiUysr?=
 =?utf-8?B?eHlBbDB3anFaK3QreU9vMXJLS0xMNFdXcktMMURNeXpqZVA4MGVQWXdtaGNw?=
 =?utf-8?B?cC93ZlNzdHptb1BNWXJpZ3prQ2pZQmVGcDJjcHZyU2pnV3h2Sm5sOTZXZEg4?=
 =?utf-8?B?ZWRXZmZyNENkdUJJYmFmajA1QUtLMklaSkN4VzhWWUR1MVBkdWQ5SXVRZUlW?=
 =?utf-8?B?RFBJSVA2cE1VendjdEJ5dWZDNlpkMnA2VDhkQTRJTERpOHFRNmJHOUZDY0Jt?=
 =?utf-8?B?OWs4a0NTK0dHdndyOUJlSDBhZEw1ZGU2REVQeUFaOXBkdmJMMk9pYi82a01W?=
 =?utf-8?B?aXVyeEh0cFIxa3RVS3VzcEliL1l5MjB1M05rMFE1d1M1S3I1VkFiT09KemUr?=
 =?utf-8?B?elh3aUtoME1JZUxPb1ZpQmVmZXNlMFo5TklweUszNGhzRlc5bU1DVGRPMUNN?=
 =?utf-8?B?Vjg4US9Mc1h2bUplT2dwalRhMzlkbUNRd0d2UTJmUHcrbFFqazhHWEVaUlhZ?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <944FD2E0E17FDF439BB9D8073179E5FC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766ab48f-00c7-45aa-570b-08d9a3bb5879
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 19:58:48.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unjXXVl+jL+WUg20hcfAoFf8VZmRZyEM57ni2aBbRap14J3XIWU+cMet2S+VESYuby+3NakXkHc51n4T1HDR7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090111
X-Proofpoint-ORIG-GUID: bGBLdVxs04P3vQIY6p7gEPnq5QzB3qSC
X-Proofpoint-GUID: bGBLdVxs04P3vQIY6p7gEPnq5QzB3qSC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvOS8yMDIxIDEwOjQ4IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IE9uIE1vbiwgTm92
IDgsIDIwMjEgYXQgMTE6MjcgUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3Jn
PiB3cm90ZToNCj4+DQo+PiBPbiBGcmksIE5vdiAwNSwgMjAyMSBhdCAwNzoxNjozOFBNIC0wNjAw
LCBKYW5lIENodSB3cm90ZToNCj4+PiAgIHN0YXRpYyBzaXplX3QgcG1lbV9jb3B5X2Zyb21faXRl
cihzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2RldiwgcGdvZmZfdCBwZ29mZiwNCj4+PiAgICAgICAg
ICAgICAgICB2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSwgaW50
IG1vZGUpDQo+Pj4gICB7DQo+Pj4gKyAgICAgcGh5c19hZGRyX3QgcG1lbV9vZmY7DQo+Pj4gKyAg
ICAgc2l6ZV90IGxlbiwgbGVhZF9vZmY7DQo+Pj4gKyAgICAgc3RydWN0IHBtZW1fZGV2aWNlICpw
bWVtID0gZGF4X2dldF9wcml2YXRlKGRheF9kZXYpOw0KPj4+ICsgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9IHBtZW0tPmJiLmRldjsNCj4+PiArDQo+Pj4gKyAgICAgaWYgKHVubGlrZWx5KG1vZGUg
PT0gREFYX09QX1JFQ09WRVJZKSkgew0KPj4+ICsgICAgICAgICAgICAgbGVhZF9vZmYgPSAodW5z
aWduZWQgbG9uZylhZGRyICYgflBBR0VfTUFTSzsNCj4+PiArICAgICAgICAgICAgIGxlbiA9IFBG
Tl9QSFlTKFBGTl9VUChsZWFkX29mZiArIGJ5dGVzKSk7DQo+Pj4gKyAgICAgICAgICAgICBpZiAo
aXNfYmFkX3BtZW0oJnBtZW0tPmJiLCBQRk5fUEhZUyhwZ29mZikgLyA1MTIsIGxlbikpIHsNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgaWYgKGxlYWRfb2ZmIHx8ICEoUEFHRV9BTElHTkVEKGJ5
dGVzKSkpIHsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfd2FybihkZXYs
ICJGb3VuZCBwb2lzb24sIGJ1dCBhZGRyKCVwKSBhbmQvb3IgYnl0ZXMoJSNseCkgbm90IHBhZ2Ug
YWxpZ25lZFxuIiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFk
ZHIsIGJ5dGVzKTsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gKHNp
emVfdCkgLUVJTzsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgfQ0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICBwbWVtX29mZiA9IFBGTl9QSFlTKHBnb2ZmKSArIHBtZW0tPmRhdGFfb2Zmc2V0
Ow0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAocG1lbV9jbGVhcl9wb2lzb24ocG1lbSwg
cG1lbV9vZmYsIGJ5dGVzKSAhPQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCTEtfU1RTX09LKQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAoc2l6ZV90KSAtRUlPOw0KPj4+ICsgICAgICAgICAgICAgfQ0KPj4+ICsgICAg
IH0NCj4+DQo+PiBUaGlzIGlzIGluIHRoZSB3cm9uZyBzcG90LiAgQXMgc2VlbiBpbiBteSBXSVAg
c2VyaWVzIGluZGl2aWR1YWwgZHJpdmVycw0KPj4gcmVhbGx5IHNob3VsZCBub3QgaG9vayBpbnRv
IGNvcHlpbmcgdG8gYW5kIGZyb20gdGhlIGl0ZXIsIGJlY2F1c2UgaXQNCj4+IHJlYWxseSBpcyBq
dXN0IG9uZSB3YXkgdG8gd3JpdGUgdG8gYSBudmRpbW0uICBIb3cgd291bGQgZG0td3JpdGVjYWNo
ZQ0KPj4gY2xlYXIgdGhlIGVycm9ycyB3aXRoIHRoaXMgc2NoZW1lPw0KPj4NCj4+IFNvIElNSE8g
Z29pbmcgYmFjayB0byB0aGUgc2VwYXJhdGUgcmVjb3ZlcnkgbWV0aG9kIGFzIGluIHlvdXIgcHJl
dmlvdXMNCj4+IHBhdGNoIHJlYWxseSBpcyB0aGUgd2F5IHRvIGdvLiAgSWYvd2hlbiB0aGUgNjQt
Yml0IHN0b3JlIGhhcHBlbnMgd2UNCj4+IG5lZWQgdG8gZmlndXJlIG91dCBhIGdvb2Qgd2F5IHRv
IGNsZWFyIHRoZSBiYWQgYmxvY2sgbGlzdCBmb3IgdGhhdC4NCj4gDQo+IEkgdGhpbmsgd2UganVz
dCBtYWtlIGVycm9yIG1hbmFnZW1lbnQgYSBmaXJzdCBjbGFzcyBjaXRpemVuIG9mIGENCj4gZGF4
LWRldmljZSBhbmQgc3RvcCBhYnN0cmFjdGluZyBpdCBiZWhpbmQgYSBkcml2ZXIgY2FsbGJhY2su
IFRoYXQgd2F5DQo+IHRoZSBkcml2ZXIgdGhhdCByZWdpc3RlcnMgdGhlIGRheC1kZXZpY2UgY2Fu
IG9wdGlvbmFsbHkgcmVnaXN0ZXIgZXJyb3INCj4gbWFuYWdlbWVudCBhcyB3ZWxsLiBUaGVuIGZz
ZGF4IHBhdGggY2FuIGRvOg0KPiANCj4gICAgICAgICAgcmMgPSBkYXhfZGlyZWN0X2FjY2Vzcygu
Li4sICZrYWRkciwgLi4uKTsNCj4gICAgICAgICAgaWYgKHVubGlrZWx5KHJjKSkgew0KPiAgICAg
ICAgICAgICAgICAgIGthZGRyID0gZGF4X21rX3JlY292ZXJ5KGthZGRyKTsNCg0KU29ycnksIHdo
YXQgZG9lcyBkYXhfbWtfcmVjb3Zlcnkoa2FkZHIpIGRvPw0KDQo+ICAgICAgICAgICAgICAgICAg
ZGF4X2RpcmVjdF9hY2Nlc3MoLi4uLCAma2FkZHIsIC4uLik7DQo+ICAgICAgICAgICAgICAgICAg
cmV0dXJuIGRheF9yZWNvdmVyeV97cmVhZCx3cml0ZX0oLi4uLCBrYWRkciwgLi4uKTsNCj4gICAg
ICAgICAgfQ0KPiAgICAgICAgICByZXR1cm4gY29weV97bWNfdG9faXRlcixmcm9tX2l0ZXJfZmx1
c2hjYWNoZX0oLi4uKTsNCj4gDQo+IFdoZXJlLCB0aGUgcmVjb3ZlcnkgdmVyc2lvbiBvZiBkYXhf
ZGlyZWN0X2FjY2VzcygpIGhhcyB0aGUgb3Bwb3J0dW5pdHkNCj4gdG8gY2hhbmdlIHRoZSBwYWdl
IHBlcm1pc3Npb25zIC8gdXNlIGFuIGFsaWFzIG1hcHBpbmcgZm9yIHRoZSBhY2Nlc3MsDQoNCmFn
YWluLCBzb3JyeSwgd2hhdCAncGFnZSBwZXJtaXNzaW9ucyc/ICBtZW1vcnlfZmFpbHVyZV9kZXZf
cGFnZW1hcCgpDQpjaGFuZ2VzIHRoZSBwb2lzb25lZCBwYWdlIG1lbV90eXBlIGZyb20gJ3J3JyB0
byAndWMtJyAoc2hvdWxkIGJlIE5QPyksDQpkbyB5b3UgbWVhbiB0byByZXZlcnNlIHRoZSBjaGFu
Z2U/DQoNCj4gZGF4X3JlY292ZXJ5X3JlYWQoKSBhbGxvd3MgcmVhZGluZyB0aGUgZ29vZCBjYWNo
ZWxpbmVzIG91dCBvZiBhDQo+IHBvaXNvbmVkIHBhZ2UsIGFuZCBkYXhfcmVjb3Zlcnlfd3JpdGUo
KSBjb29yZGluYXRlcyBlcnJvciBsaXN0DQo+IG1hbmFnZW1lbnQgYW5kIHJldHVybmluZyBhIHBv
aXNvbiBwYWdlIHRvIGZ1bGwgd3JpdGUtYmFjayBjYWNoaW5nDQo+IG9wZXJhdGlvbiB3aGVuIG5v
IG1vcmUgcG9pc29uZWQgY2FjaGVsaW5lIGFyZSBkZXRlY3RlZCBpbiB0aGUgcGFnZS4NCj4gDQoN
CkhvdyBhYm91dCB0byBpbnRyb2R1Y2UgMyBkYXhfcmVjb3Zlcl8gQVBJczoNCiAgIGRheF9yZWNv
dmVyX2RpcmVjdF9hY2Nlc3MoKTogc2ltaWxhciB0byBkYXhfZGlyZWN0X2FjY2VzcyBleGNlcHQN
CiAgICAgIGl0IGlnbm9yZXMgZXJyb3IgbGlzdCBhbmQgcmV0dXJuIHRoZSBrYWRkciwgYW5kIGhl
bmNlIGlzIGFsc28NCiAgICAgIG9wdGlvbmFsLCBleHBvcnRlZCBieSBkZXZpY2UgZHJpdmVyIHRo
YXQgaGFzIHRoZSBhYmlsaXR5IHRvDQogICAgICBkZXRlY3QgZXJyb3I7DQogICBkYXhfcmVjb3Zl
cnlfcmVhZCgpOiBvcHRpb25hbCwgc3VwcG9ydGVkIGJ5IHBtZW0gZHJpdmVyIG9ubHksDQogICAg
ICByZWFkcyBhcyBtdWNoIGRhdGEgYXMgcG9zc2libGUgdXAgdG8gdGhlIHBvaXNvbmVkIHBhZ2U7
DQogICBkYXhfcmVjb3Zlcnlfd3JpdGUoKTogb3B0aW9uYWwsIHN1cHBvcnRlZCBieSBwbWVtIGRy
aXZlciBvbmx5LA0KICAgICAgZmlyc3QgY2xlYXItcG9pc29uLCB0aGVuIHdyaXRlLg0KDQpTaG91
bGQgd2Ugd29ycnkgYWJvdXQgdGhlIGRtIHRhcmdldHM/DQoNCkJvdGggZGF4X3JlY292ZXJ5X3Jl
YWQvd3JpdGUoKSBhcmUgaG9va2VkIHVwIHRvIGRheF9pb21hcF9pdGVyKCkuDQoNClRoYW5rcywN
Ci1qYW5lDQoNCg0KDQo=
