Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBB4D3FAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiCJD3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiCJD3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:29:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2874100772;
        Wed,  9 Mar 2022 19:28:04 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1JNMh009117;
        Thu, 10 Mar 2022 03:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wfQBMqzdM5AcZVwT6ZiAU7ir8tM3U2NF7rltmHqgG2k=;
 b=MWqYhKb8i72UQqobvQ8ePb71nTv1wYF42DxBYj//xAqrVjMAl5Pkj43gonDMWLt0y0r7
 uX7lhgte6h3bBpv5Ft9H0OBOSiJngzPp+SWwsq1KvCP/fXLT05VduXeLQufIOusihDzB
 CNrXd4N68e+MAX3nZewtT0ovVDjEo4GWVNJU4Zkor6wCLiQioLDLIeqWh8MJv6BztKyA
 dCjxo9Q69oM9hDVhpGfem16YleG/vpgKMcGYVuYYJ9vTVXvNGc2I5MBmlenE9xVE+kHF
 gIqoInjnCa28bO77fcfSquGvynF02SYcIwgXTfX1SwmH2WyS83nZTO2JIRsyFtLHZGoG CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2m3vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:28:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A3GQQb151196;
        Thu, 10 Mar 2022 03:28:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3030.oracle.com with ESMTP id 3ekvywby1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 03:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aye9rAMoiij7M0+6/nXrElycQr48jUEmp9Zwruev7JlW971/L59QzqWTilbkmqyo3UerHmYQ7agKeSFyynw03wbbEqi0kfH7cfMQxYQi9BVTXO/MJcMVVAsb7RU9dox/mBZy6Uw41ap7jo3VTdScCFLyI5rtRSYcFn1vGF7lVFaucekIraZS4L3CJt4guv39L/iXblmiOzAcKRxgllO4FXzAVG+cILD3x6lE8X/pOtjHiLmUf112YDkt5VEpni4xMnqo5vy7b/erGFAYcLFEYyo+SxWusc6z9Xtb8cf+V/1l09zLlHHC4XGdb9mcX37eoN43PyhGc6Ti2ZDZ4zUDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfQBMqzdM5AcZVwT6ZiAU7ir8tM3U2NF7rltmHqgG2k=;
 b=PGxvL2cC+tAr9V+fKVfOsn+G+nudU9JC0dzdf+rLoTmWHLzZB1BlZoOjOXaBhaGAnWgxnFfOT2FyhrI5CVImbL39OEaDwKGAIWRC7K7YjDMhpc7GJZNUWxM+zGLWWc/vmABbUr/zvpNG8WKJHnsEUOJFC8JE76Jzed7tpw90YE8ucHTZISI/2EIpGDQt6uj1nhtr+8xYRQExKPT3S8ZPIRFNT4QQyfb1t1EX0GUSOL1we5Sc6AJajpV+6oGtu0DcDd7MwSpj0jvnVB5hVnbGoQlGPunDa5H/tVihDGvYNnbybPFBvI/jSuZypqWsuKufb4zS5N1hMsWWrWhQMFbtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfQBMqzdM5AcZVwT6ZiAU7ir8tM3U2NF7rltmHqgG2k=;
 b=alNdyeU7XA64aetVAGUiiofpIYQ382AytZpxXkFhmxPu/X5jSIYj7pDBHiftZzxz7LJvOLG6a6xBWhN23+oWkeuOfc2XrbqCFPzBxynT5bHzDGp3mpxKhPRxt779iOa0Mhm8xHDK44wMi3+L+CAa05jd9fZZfDiqVCgf8M3t1vM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3961.namprd10.prod.outlook.com (2603:10b6:5:1f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 03:27:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 03:27:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Thread-Topic: [PATCH RFC v15 11/11] NFSD: Show state of courtesy clients in
 client info
Thread-Index: AQHYMCkx0/hr3YEM/0Sucgyj906cvKy3hEEAgAAKNICAAGnRgIAABRVa
Date:   Thu, 10 Mar 2022 03:27:58 +0000
Message-ID: <892A7E1F-2920-47DB-9E15-21CE73093893@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-12-git-send-email-dai.ngo@oracle.com>
 <E1AF0991-A682-4B98-A62F-3FE55349E30F@oracle.com>
 <c5a82f64-d1a5-3ec5-2bbf-4bd596840cf2@oracle.com>
 <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
In-Reply-To: <ba8b4983-804d-607f-325e-c9be24c23fcb@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 137f5e89-3ea1-421f-3cad-08da0245f97f
x-ms-traffictypediagnostic: DM6PR10MB3961:EE_
x-microsoft-antispam-prvs: <DM6PR10MB39613C44B6E1C55609EDA9AE930B9@DM6PR10MB3961.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkvvQjWAgphIFupqIplqx+c2lbv9ljvLJ7h5/kk3wriNxUwQCyJY1ZTeUQFlxw8WEyKOoAGWNAZCx5iigwbCzezsjao7K7Yp4W0Ay7oiKQmRSH+Rvk7kbWIGPFxf7sclnbN7xlKQos5WQvXsBn6+Tck25C+XMAohgAJKUdV/N5ecwBAIUIoaEhBV3lII89OEJmuP5dvBMRvO6uxAu4efUA912oqkPU0HQfI1G3R43jeFbw3CHxnfzh1cPm7qSJwx9maHHbvl2P3MlNOlq1R3Fa0R6fMcfABwExg5zMKjUJN9H4t12+hKThzeTi72MROD/jp0GP/VkJn60DXJQe084E8x9ByIxPbnzQgy0MyftKM04Fmwb9c6Mr0a6RBJMf3AmGHpY9/iabGjbb8Ve0XpAFR6h/IHgEazQxGrYbA211okHGmn+bz0QD/fQZ7mtoETF+3R+jO11CVidD31y8UW7Ju6EoL73++JNoia1E2QHucvr0jmmvFfFC6ZOTjzR3CwF+W9vDdpf8vesaJoGk75RqyAah/Bzf9p2/n4BRXUrbwUCuOGMieZYcirvTL+5jDkriuuq4hm0EBVCTiSruRFpZL55qHvdvqQZ+9x+rLlH9P04Lul8pXu7PLuJmpNFIyVnBoDjlu/pdDZEEJ4AkwvD06ic6Lu5R+XaDJcMHPYwHrQ74U62znvFTfFFPNjfp+V3Hxxw7uqRVQo2KZcZ0Iys82SCFHDTQmuF83wAPJriSVBsy1qqOGu5B9to9YGuPdj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(33656002)(6862004)(4326008)(76116006)(6486002)(91956017)(66946007)(64756008)(508600001)(66556008)(66446008)(316002)(66476007)(83380400001)(8936002)(5660300002)(122000001)(2616005)(86362001)(38100700002)(38070700005)(186003)(6506007)(53546011)(26005)(54906003)(6636002)(37006003)(71200400001)(6512007)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3pGSUwvNmhHVUQyUTcwZWR6M2piU1RMOVhXOUZESWRaTzZYckZCN1A4NzJ1?=
 =?utf-8?B?NkEwV2NmUjVKQUJpcktsOHlHYS95UDA3dG9PRW94eDlKOTRrWjduenl4UE9a?=
 =?utf-8?B?a1JFQnJuWEhncUY4dXhaVFIwbkhjR2RwaGRhZGc0MEhwNjVtYmt0b0Vhc3RL?=
 =?utf-8?B?RlZYNnQ4QTBNT2pZYmYxZENzL2lpMTAxeXlqME5EU0V4RXNVUzBlbnJzcEdV?=
 =?utf-8?B?QlRVbVkxSnRvcmE5ekh0VkJwdEVDYWVxUFVEckIvVjh5eVhZZUF3czRHdE5v?=
 =?utf-8?B?NVU4NlVScnNpTDR6YzIyWWpLTkhibWE5TW5tMktQSnJVS0tDN1RjYUVFUnZ6?=
 =?utf-8?B?K1RtcjFxU1RPVTVJRVpNOVBJSzVsbmgvTGd2dVhLMzEyQ3ZZb3lUalVxM2Jy?=
 =?utf-8?B?UWdqVU9SUWc1c3JQYkhhVDFQdXhTdkVWQ3Zad1Q1M2FJMFppKzZpMFUybDFp?=
 =?utf-8?B?bTdvV2RqREJIRUNFMWFOWTMwTVRvcFNnWWdPdHpHME5mWmU3KzhpLzFNcDV3?=
 =?utf-8?B?clRVb2tnVEFyNDNuOWFqNUFrejNmM3BCSFBQWlFCTjVxRU03c2hYZFk4RjJp?=
 =?utf-8?B?Vmd2STRiVGtaQ3A2dEFvVDl5cHViYUZKL1lTNEp4SjQzb20wNFN5Y1djZ09Q?=
 =?utf-8?B?MElXRERYUkpRUE5nbGI3TE9EaWlVaTFpUU1TZTBnTVV4ZlY2cndTQ0JNU3lj?=
 =?utf-8?B?THVZRUowS3RkN1N0eDdBNmVVMHQzOWlLYURlWVYwNXFnVU1mcllPRVN2VEZU?=
 =?utf-8?B?SGUyQlgzQ0Z2bnE0RlJaRXIrZ3E3d2FMemZUNTN0NjVvM0hEOGFCeVVmaHlT?=
 =?utf-8?B?NW1NWmhZejVhZ0NpZG0reGkzOXE1Qk9OSHhOOHJMN2ltVldDYnFiQjZOZHlm?=
 =?utf-8?B?R1BtbzVBL0QzUW5tZkJ5N0FCNXFTWlJWVkw0bWRadUFuaFh5SVd2TDUwcGta?=
 =?utf-8?B?ZWVoajhmOUdwcUFLS1hWa0RMdEhsVTdGcFpCelVxSlBNMmcwMmcxeUpVcHRq?=
 =?utf-8?B?b1NkTklMa3Qxc3FlbW03S2hkcWo1eGZxOEI1SWZVNldQakRBNC9jZ2dSVm13?=
 =?utf-8?B?aDBIV2JBOHI2RzRKSjU3dGYwMVl5V2ZEZmlPMGpwaWN3eG1GY1E4QnlPVVlx?=
 =?utf-8?B?czZxb1JSQVd0NkV6K0JGU21zem1nTzJja3Nmc0VNY2JkOHdZN3VXWE5HMEJR?=
 =?utf-8?B?YlhyNjNub1RqNG1vcGNWZmtOQ1JUN056bWFMYk1MMDBkcWxpN2FUd3Jza2Jl?=
 =?utf-8?B?MVZNWnFTQUlzaXZ4ZXRZVm5MazYzM0JXeElJTGt1RThVeloycXQrTWdHWklE?=
 =?utf-8?B?WWI4U3FPcHZyNzRYcm9SQUJzakNMMGdhSHUzNDlxMURvNCswOWxsNzFuYzQv?=
 =?utf-8?B?QkNvZkxqRE9uQlJZcGMxU1RaeE1aeVozUTVGWndqM0NsVVNxMVBiWVlneDdD?=
 =?utf-8?B?Y0E0U29QVVhTeUozYXNPcFB2WUNUTDYrc2twUXVBb2RQTmIwcTFDdUROREVh?=
 =?utf-8?B?dkRkK2tDb0FWamtrSFRzdFpQVVpOTzRPTU45WEc3aDZ1VUM2YzA5dXQ1Unpq?=
 =?utf-8?B?ZEgya1kycmtsWjNtSHV2UGpHdERjSlNYdHlobDhWcFpLK3BncmI0cVNwSjBt?=
 =?utf-8?B?d3o0dW1UTGZEeXlQckR5WWxBNmhKRnNEa0w5Mm5HUVNGb3p5dkxUZlFLS0Qx?=
 =?utf-8?B?OWtuK0VLRXYyOVF0WUZqaG5xc09GVzFhVGxFS1puM2xLMklkajBWRXIwTzFn?=
 =?utf-8?B?aHREbGM4Y3gycUJRemVkU1FRWFU1NnJHbm1MQVJJMHdpWEltcG04TDIzNlBu?=
 =?utf-8?B?ZHBYZW1ETDhCR2NtZWZ3QVN5RG5xd3RUREl4UFR3MXZiczd2MisrSjFBOUI0?=
 =?utf-8?B?VVluRk9lVFk0Y2VYSjV3bnllVHR6YllxbEFEajFNVURWSGlBRkRod3dsVzhG?=
 =?utf-8?B?OXQvWXM3UGNMWSt4dkN0Ny8rcmpJSmIxVS84WHR3MmJrSUx1UTRrR1pLclMr?=
 =?utf-8?B?T2VvUEl0dnVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137f5e89-3ea1-421f-3cad-08da0245f97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 03:27:58.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzwLh3CTKLq4QDVvD10PdjwUzQoSEPaY4Rr1hvBpXKmim1Hk89QOBqBypiBlLchceR9CbKVaOp5Bj7kV8VErhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3961
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100015
X-Proofpoint-ORIG-GUID: j0hZgb4nsAhyzskcp0YkTzlSoUVBtR29
X-Proofpoint-GUID: j0hZgb4nsAhyzskcp0YkTzlSoUVBtR29
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE1hciA5LCAyMDIyLCBhdCAxMDowOSBQTSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUu
Y29tPiB3cm90ZToNCj4gDQo+IO+7vw0KPj4gT24gMy85LzIyIDEyOjUxIFBNLCBkYWkubmdvQG9y
YWNsZS5jb20gd3JvdGU6DQo+PiANCj4+PiBPbiAzLzkvMjIgMTI6MTQgUE0sIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4+PiANCj4+Pj4gT24gTWFyIDQsIDIwMjIsIGF0IDc6MzcgUE0sIERhaSBO
Z28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBVcGRhdGUgY2xpZW50
X2luZm9fc2hvdyB0byBzaG93IHN0YXRlIG9mIGNvdXJ0ZXN5IGNsaWVudA0KPj4+PiBhbmQgdGlt
ZSBzaW5jZSBsYXN0IHJlbmV3Lg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogRGFpIE5nbyA8
ZGFpLm5nb0BvcmFjbGUuY29tPg0KPj4+PiAtLS0NCj4+Pj4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8
IDkgKysrKysrKystDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIv
ZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+PiBpbmRleCBiY2VkMDkwMTRlNmIuLmVkMTRlMGI1NDUz
NyAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+PiArKysgYi9mcy9u
ZnNkL25mczRzdGF0ZS5jDQo+Pj4+IEBAIC0yNDM5LDcgKzI0MzksOCBAQCBzdGF0aWMgaW50IGNs
aWVudF9pbmZvX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPj4+PiB7DQo+Pj4+
ICAgICBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gbS0+cHJpdmF0ZTsNCj4+Pj4gICAgIHN0cnVjdCBu
ZnM0X2NsaWVudCAqY2xwOw0KPj4+PiAtICAgIHU2NCBjbGlkOw0KPj4+PiArICAgIHU2NCBjbGlk
LCBocnM7DQo+Pj4+ICsgICAgdTMyIG1pbnMsIHNlY3M7DQo+Pj4+IA0KPj4+PiAgICAgY2xwID0g
Z2V0X25mc2Rmc19jbHAoaW5vZGUpOw0KPj4+PiAgICAgaWYgKCFjbHApDQo+Pj4+IEBAIC0yNDUx
LDYgKzI0NTIsMTIgQEAgc3RhdGljIGludCBjbGllbnRfaW5mb19zaG93KHN0cnVjdCBzZXFfZmls
ZSAqbSwgdm9pZCAqdikNCj4+Pj4gICAgICAgICBzZXFfcHV0cyhtLCAic3RhdHVzOiBjb25maXJt
ZWRcbiIpOw0KPj4+PiAgICAgZWxzZQ0KPj4+PiAgICAgICAgIHNlcV9wdXRzKG0sICJzdGF0dXM6
IHVuY29uZmlybWVkXG4iKTsNCj4+Pj4gKyAgICBzZXFfcHJpbnRmKG0sICJjb3VydGVzeSBjbGll
bnQ6ICVzXG4iLA0KPj4+PiArICAgICAgICB0ZXN0X2JpdChORlNENF9DTElFTlRfQ09VUlRFU1ks
ICZjbHAtPmNsX2ZsYWdzKSA/ICJ5ZXMiIDogIm5vIik7DQo+Pj4gSSdtIHdvbmRlcmluZyBpZiBp
dCB3b3VsZCBiZSBtb3JlIGVjb25vbWljYWwgdG8gY29tYmluZSB0aGlzDQo+Pj4gb3V0cHV0IHdp
dGggdGhlIHN0YXR1cyBvdXRwdXQganVzdCBiZWZvcmUgaXQgc28gd2UgaGF2ZSBvbmx5DQo+Pj4g
b25lIG9mOg0KPj4+IA0KPj4+ICAgICBzZXFfcHV0cyhtLCAic3RhdHVzOiB1bmNvbmZpcm1lZFxu
Iik7DQo+Pj4gDQo+Pj4gICAgIHNlcV9wdXRzKG0sICJzdGF0dXM6IGNvbmZpcm1lZFxuIik7DQo+
Pj4gDQo+Pj4gb3INCj4+PiANCj4+PiAgICAgc2VxX3B1dHMobSwgInN0YXR1czogY291cnRlc3lc
biIpOw0KPj4gDQo+PiBtYWtlIHNlbnNlLCB3aWxsIGZpeC4NCj4gDQo+IE9uIHNlY29uZCB0aG91
Z2h0LCBJIHRoaW5rIGl0J3Mgc2FmZXIgdG8ga2VlcCB0aGlzIHRoZSBzYW1lDQo+IHNpbmNlIHRo
ZXJlIG1pZ2h0IGJlIHNjcmlwdHMgb3V0IHRoZXJlIHRoYXQgZGVwZW5kIG9uIGl0Lg0KDQpJIGFn
cmVlIHdlIHNob3VsZCBiZSBzZW5zaXRpdmUgdG8gcG90ZW50aWFsIHVzZXJzIG9mIHRoaXMgaW5m
b3JtYXRpb24uIEhvd2V2ZXLigKYNCg0KV2l0aG91dCBoYXZpbmcgb25lIG9yIHR3byBleGFtcGxl
cyBvZiBzdWNoIHNjcmlwdHMgaW4gZnJvbnQgb2YgdXMsIGl04oCZcyBoYXJkIHRvIHNheSB3aGV0
aGVyIG15IHN1Z2dlc3Rpb24gKGEgbmV3IGtleXdvcmQgYWZ0ZXIg4oCcc3RhdHVzOuKAnSkgb3Ig
eW91ciBvcmlnaW5hbCAoYSBuZXcgbGluZSBpbiB0aGUgZmlsZSkgd291bGQgYmUgbW9yZSBkaXNy
dXB0aXZlLg0KDQpBbHNvIEnigJltIG5vdCBzZWVpbmcgZXhhY3RseSBob3cgdGhlIG91dHB1dCBm
b3JtYXQgaXMgdmVyc2lvbmVk4oCmIHNvIHdoYXTigJlzIHRoZSBzYWZlc3Qgd2F5IHRvIG1ha2Ug
Y2hhbmdlcyB0byB0aGUgb3V0cHV0IGZvcm1hdCBvZiB0aGlzIGZpbGU/IEFueW9uZT8NCg0KV2hl
biBJIGdldCBpbiBmcm9udCBvZiBhIGNvbXB1dGVyIGFnYWluLCBJ4oCZbGwgaGF2ZSBhIGxvb2sg
YXQgdGhlIGNoYW5nZSBoaXN0b3J5IG9mIHRoaXMgZnVuY3Rpb24uDQoNCg0KPiAtRGFpDQo+IA0K
Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+ICsgICAgaHJzID0gZGl2X3U2NF9yZW0oa3RpbWVfZ2V0X2Jv
b3R0aW1lX3NlY29uZHMoKSAtIGNscC0+Y2xfdGltZSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAz
NjAwLCAmc2Vjcyk7DQo+Pj4+ICsgICAgbWlucyA9IGRpdl91NjRfcmVtKCh1NjQpc2VjcywgNjAs
ICZzZWNzKTsNCj4+Pj4gKyAgICBzZXFfcHJpbnRmKG0sICJ0aW1lIHNpbmNlIGxhc3QgcmVuZXc6
ICUwMmxkOiUwMmQ6JTAyZFxuIiwgaHJzLCBtaW5zLCBzZWNzKTsNCj4+PiBUaGFua3MsIHRoaXMg
c2VlbXMgbW9yZSBmcmllbmRseSB0aGFuIHdoYXQgd2FzIGhlcmUgYmVmb3JlLg0KPj4+IA0KPj4+
IEhvd2V2ZXIgaWYgd2UgcmVwbGFjZSB0aGUgZml4ZWQgY291cnRlc3kgdGltZW91dCB3aXRoIGEN
Cj4+PiBzaHJpbmtlciwgSSBiZXQgc29tZSBjb3VydGVzeSBjbGllbnRzIG1pZ2h0IGxpZSBhYm91
dCBmb3INCj4+PiBtYW55IG1vcmUgdGhhdCA5OSBob3Vycy4gUGVyaGFwcyB0aGUgbGVmdC1tb3N0
IGZvcm1hdA0KPj4+IHNwZWNpZmllciBjb3VsZCBiZSBqdXN0ICIlbHUiIGFuZCB0aGUgcmVzdCBj
b3VsZCBiZSAiJTAydSIuDQo+Pj4gDQo+Pj4gKGllLCBhbHNvIHR1cm4gdGhlICJkIiBpbnRvICJ1
IiB0byBwcmV2ZW50IGV2ZXIgZGlzcGxheWluZw0KPj4+IGEgbmVnYXRpdmUgbnVtYmVyIG9mIHRp
bWUgdW5pdHMpLg0KPj4gDQo+PiB3aWxsIGZpeC4NCj4+IA0KPj4gSSB3aWxsIHdhaXQgZm9yIHlv
dXIgcmV2aWV3IG9mIHRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGJlZm9yZQ0KPj4gSSBzdWJtaXQg
djE2Lg0KPj4gDQo+PiBUaGFua3MsDQo+PiAtRGFpDQo+PiANCj4+PiANCj4+PiANCj4+Pj4gICAg
IHNlcV9wcmludGYobSwgIm5hbWU6ICIpOw0KPj4+PiAgICAgc2VxX3F1b3RlX21lbShtLCBjbHAt
PmNsX25hbWUuZGF0YSwgY2xwLT5jbF9uYW1lLmxlbik7DQo+Pj4+ICAgICBzZXFfcHJpbnRmKG0s
ICJcbm1pbm9yIHZlcnNpb246ICVkXG4iLCBjbHAtPmNsX21pbm9ydmVyc2lvbik7DQo+Pj4+IC0t
IA0KPj4+PiAyLjkuNQ0KPj4+PiANCj4+PiAtLSANCj4+PiBDaHVjayBMZXZlcg0KPj4+IA0KPj4+
IA0KPj4+IA0K
