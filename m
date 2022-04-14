Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9D50033F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiDNAyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 20:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiDNAyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:54:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE113DA58;
        Wed, 13 Apr 2022 17:51:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23E0Z1AP028126;
        Thu, 14 Apr 2022 00:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M8LBMGNSq9ULCv7gtv9Rc8ZM2zxWCSDONrEXt1Q3CWY=;
 b=gyuv7XR+7eahd6ih2vGp+0EbBtvDIPo3DObnstbamJ8p3QpG1D6f1QmoG6nGCTFSMG6b
 JqkQOINITdfh1GwY6NG1iNghuSuMdR657y7KlTh0WIYDqCWV1fIdtpG3om8lpRbYR07u
 kWxNtuFyz9f5t0GYVjsYoCpBHucqlxzLLUdonwBxMEQ8YW+3/mplJZKsqiGUqkpA/yOL
 exbvVsJX+51cZ8A7rIcascOXTLl46oxGa0PhOnA6Cc5CaP+7K3Hw4ZWF2FrgR4TC7T4U
 GZB/uAz8pk0f9BWZ7XobRTP4JOOkp1sVE97WGXCj3Wtp+eyw6qD8MlrCGOCj9HMxNWJJ 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a32db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:51:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E0kT0L000829;
        Thu, 14 Apr 2022 00:51:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck14g4nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzfKPSz5kI8MM3i5i6D6/3pyyE38E+ATA0kZwO9GmgenXHrBr5dQhzCGXCmt4edQokp/m4r8JpTfGJ74uxT2Xa06Wwmqhhr4p3aaVswicloRdeCQhTFa9N6HsCn4hohEqjWXw7trc8WqRGF00ydJgUAlzsOE97FS0oF0SHrG+X0rG9S8jsDpOuIDpK9dqzfELbpVzy4FeNGqWDQM0LY27hzNJVkr4q6kGTp4stbVVC7OG9chYN+xu+eld1+kwOKeruX1NcalvSo0DI1MjJBR0hJ24oDKGmilzYvUEO1dkuxIkKrzC851+vC0dlR0PtcV3CyF0gKoRUOPAHWJXXfskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8LBMGNSq9ULCv7gtv9Rc8ZM2zxWCSDONrEXt1Q3CWY=;
 b=XoFzRuTxpQRgFAYCBshkTIInUBHZObOsG5uyU23wEaBuWdO9x4jZvCm36HQ5kzPMCbAJ4lpv0nKWwYZOwPWtW6SR3q1/o0THe8pSlOURi+h4lHArBbsa8wGqGIqYrzxoTBx6aiMft79CpVT8mXPKpiboinpPE7Vh9tfqBmrSoVrtSzYdBwTq6S8UzgQg0nmxTY2KjuNROVsIaYiHR5J/r+QVP4TWhOXmSoXjvnhcG70L+vSU2Z/NW5/gr+wxhvaXhEEo7FOpUzwT5j9SsACH5ZK7+DUI8peGk03Xgu1DxUFUo65UCj1oero9ETIcM5A0nsYyWXMZ0F25tS9oes6LKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8LBMGNSq9ULCv7gtv9Rc8ZM2zxWCSDONrEXt1Q3CWY=;
 b=WSrPhKefi7KwyQ/9zy6EBV3MR6Clfwr5I4istL+KxMzjGG4ZQmWw4+2q4GG8I5rPSRkkrvfLxv14Q+pO8XcwB6u3v5zpGqDfJlPNavrtAu7tL+Y18y8pQoZ1rbpw6Lk+tJxMaonbXEO464yzqCsFdsoADfpObgjI+QtcMs1K7Ws=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3462.namprd10.prod.outlook.com (2603:10b6:a03:121::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 00:51:28 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 00:51:28 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
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
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Topic: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Index: AQHYSSYdGKTdETDbkEmdZR/SZY7Ic6zrwVsAgAABT4CAAt6UgA==
Date:   Thu, 14 Apr 2022 00:51:28 +0000
Message-ID: <90b46d82-f4ed-db07-b3a4-31cf806f1d96@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <CAPcyv4jpOss6hzPgM913v_QsZ+PB6Jzo1WV=YdUvnKZiwtfjiA@mail.gmail.com>
 <YlUH2f66hMyXOP1r@infradead.org>
In-Reply-To: <YlUH2f66hMyXOP1r@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea18c10-046b-45ea-166f-08da1db0e8a5
x-ms-traffictypediagnostic: BYAPR10MB3462:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3462344FAF9B745523FEE64DF3EF9@BYAPR10MB3462.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWiKhh5hfQaEodtLhxcIlgPPwz6UWgWWYG1VN5wHOaoaIiqrNkp0R8FS+SXS0xK2PoacdeQz/I3V8r+8+W17rF4KaGPopiCn9H32K6Z0Eyjikbav+qIiYrkpnJ9SZ+5vdtAME4k4vF7iWMji9JREC7zb1rLBPBIBuO7ZY7b5TfIAvD6vsA+Cz0yBOGiTvPVU4g7KzfFf2295dwOxkMt6bYwHaz69tVCDfX1fqzkgJaNVZgTVMTT4AG4vlugBgw2KZXCQx1c5RgCi3cqqETR/mB+36OggzonXNUK1DtuOLSVOIJm2phm3xayS1l2XvzOwwI6927DXoaHkDVbx4mhZo7hDDqN3EbLHvWVVO5vr5NBTz958nFiH0eX2/iVHzDBROnO1C9lWWMa+42J7TC75aKAWkDB2Ix6jdFlEog4rU3sgAYAitj358ZuLB/D87Knh174+5fhixJCTAiSIsVa4mPrm3AcfpU2LrWtniphk4S3xNwurmETz+yIGRkR5/P2RAUAwKnm4dWxRuTqkGykr6Gh9bUGKLZCdIuEEWSNsKs7rVl6/RXspAUWOy5BLSQPpgc5+pXLqz+UvCZyMIqnzjyuArWd9nDA+QdsYhr1xd8ALVPmn1A/z6sOMihwE65soBiU3cbcGi0X61RUNRXJlBMxEeGJpgoacCpCLLo3yZTcZrfh0aqZf0ZbUwFUdov3C3xOCr+FU5s2+2XF9il8MJff3n6n/+xcvLY5oEztQx5yFXzWMofZKpNaTL2k4nVgXF/ezQG6afoVQQtaXYxD3XJFwmpjgbphtzBbvPL5YxW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(91956017)(86362001)(2906002)(53546011)(31696002)(8676002)(64756008)(66446008)(66476007)(66556008)(71200400001)(36756003)(4326008)(66946007)(76116006)(31686004)(110136005)(54906003)(4744005)(7416002)(6506007)(38100700002)(6486002)(5660300002)(8936002)(508600001)(44832011)(2616005)(38070700005)(83380400001)(186003)(26005)(122000001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXVuRG1tREN4SEhYazdCTXRrZGtrTk94OFpPT3RwUEFOQUZCQ0xZUDkzV3NT?=
 =?utf-8?B?WDdLTFQxU3g5c1ZURW0ya1N4WWNURHhhNExpZmZheXZpc0VmVWxNMkNOUFJO?=
 =?utf-8?B?YzlYcnFKT3hOTWpnck82Y1VRdGZvSzd3ZmpnVnhUTy9iKzJCS0lQdVZYSWJw?=
 =?utf-8?B?M0pDSm9QT01USExvUHhYZkszbXdIVXYvOXNneUNQUXVFSDdQQ3ZMMlhuNGpQ?=
 =?utf-8?B?VlQ0aG5uOGZBdXVsRzFqS3hQWWQ2RDg3eXBKZC91Q2JEVUh4UUlCMkhVdU8y?=
 =?utf-8?B?NUFKMUF6L2xvcjllSFJpM3Nyc2d6NVNCayszTFRVYjRUNW8zSlF2M0x2R05p?=
 =?utf-8?B?aEs1Z21uWUZJVjErWFE0dC91UTkxazFvZks2VzFPYjVaak0weVJTV0NnZ2RE?=
 =?utf-8?B?cEg5Tm5kUngzRHZIeFdZRkI0ZFNoRkEwWXUxTy9Cc2VBT3ZIZ25TcDhpTzZ4?=
 =?utf-8?B?Wno0c0RxejFVbDVFOXNBYStoWkpPVm1OeWxSNy9FYlh3bmw1NjdpMXUrS1dD?=
 =?utf-8?B?OTZqZ0p3dGozd1ZlS1R3enJIWkpZc0xEMkdSK0hvd096a3ljNUV4OXkvVlha?=
 =?utf-8?B?cmZ1NS9iSVdPVlNzVlluVmc4Ykg1NVVDZ3hXVVJBUFExaHdDVnBGQ0lHQzQy?=
 =?utf-8?B?enpKcmUxa3phY281NUJtNzVqb1hLOW9mVDdTUDZoN0xjSjl0UXN2YjI4c1ha?=
 =?utf-8?B?ays2UEsyRFMvamx3UG1acEQ2dlN6SFFxY2VVYmJ2ZWRVWU1Cb3I0NjZtSEsr?=
 =?utf-8?B?V0kyTEt4NFZSYWFrWVE3MFBRdVRVSTZZU1JLNXpjc21OTlozeTRWUHRtckJH?=
 =?utf-8?B?Y1dqMWVSdEZUeloyMmhqU0xwNm5tZTJtR0FSVnl6ZElKWTRYcmwvZWZPV2ZW?=
 =?utf-8?B?S3ZVYk93Z29uNnVYd2czbFJQUW42UTVvOHdjcmdlQm5TZmxrSlg2dFlxcG9y?=
 =?utf-8?B?Mnl5WjNGRllmbnRJSGFmMkhzREtqSWFNNE1VbUFPTm0wRloxVlQ2WERSSW9I?=
 =?utf-8?B?R0tjanh4d3FoazFzSW1QeEU2alQweHZOZVNJdE5uYU5rTEh3eWZPRCtzSnI0?=
 =?utf-8?B?Z1ZHbzNGYmc1WnVVNS9lTG1WMFZLVWV0anFzZkZndFhYVS9WbGdsK2I5SXdP?=
 =?utf-8?B?bE1TdExJRndKMU04N2dxQlVCOWNNYVFKRWdoSHF5d2pybzVmb212c1lUSnV5?=
 =?utf-8?B?MUJQZGZsYk9VcXFVb2NJa0hUVThRSWJUVHZWUWVMRVpmaDgrU2lNRFlvcG9J?=
 =?utf-8?B?M3creWJEeWd3cVVIWi9HUisvYk9ZU2lZSmZuZUZlNEJLSDlDaFdEYVE4TGFG?=
 =?utf-8?B?Ni9aVS9qMVlSQXZrOUs5RFJJd2RUaDhmM3FKRkZlMzJkaytNK2dQcWlnRnVZ?=
 =?utf-8?B?WlVrY1N1b0VadENRY01CTXFvU3M3WkNvT3kyTVdMQWlrbHArMEZUamo5WlRG?=
 =?utf-8?B?LzlHQlRqNEpnMzNWblFPRG9oak5La1p5bFppanV3U05lWEllQ1NDS0p5ZHFt?=
 =?utf-8?B?OGxmMzNEUlVKK3l6cGFzUTNISEFRVFlBeU5JdVNYNkF3d2dBeDBkYU84d2tK?=
 =?utf-8?B?ZW5STXh4QzEzaiszNFBsNlRCaFBGYnRaaFFQeGQxS21BSW96VTNRdldWblRX?=
 =?utf-8?B?aC81WmJRbW1YdWVpODlQTkpQWEVFeUlaaWFVTkxtODM1bWhZSWRRSjFDZkk2?=
 =?utf-8?B?dXVvN2Zzb1JsTVEzdmh2dGdybnRtRzByb2xQMXliZ05oYnltdGYveXhLNlZw?=
 =?utf-8?B?ZithTkdiMlg1dnFQZUhHOHRNMnF3YktxeG9ac01Qd3Rza1M3NXFEcG0vcHhu?=
 =?utf-8?B?Ylg0b1RQT1lvby8zSkJQQmZnWmJlbUZ1ajhxRS9SQ0ZucUc2Nmdlc2JwQVRs?=
 =?utf-8?B?U2JjUUt4Um5lWVJtV2hoeGhtSU9GcDdQWWFGSnZMY2R5M3hBaG9XUllxL0xO?=
 =?utf-8?B?TkxTamcreVF0eUhxZThUdGNsbkhqZ3dtR3lreE1qaW5ta0Y3TlV1K3dsYkc4?=
 =?utf-8?B?eDFoTHRmbWJjWnNWWXJhbnNSSms5T2hGQllTbUFXRlArdGVNOUgzNjhxR2Rq?=
 =?utf-8?B?M0U5UkZQNjZ3c2IrSlkrV0Q2Sys3d2JzSkFBaEZtRjZUbVNDU0h3aklOczYz?=
 =?utf-8?B?Y0wxRm00Q3JmOElYMmFYSEl2Skt1TzY5NHppY0llUG8rY1NQdnFIdTdtTHA2?=
 =?utf-8?B?andldVFnc1FCZUVYbmY5cWpLSVRvYmJJOE1ZUmFaQ3ptdlhKODV0MDZ6Tmhu?=
 =?utf-8?B?bC9FSENNMXhOUmJEN1p4R1p6MGY5bWtadlNxNGdxR2xrSm9EMlFoZWlyOUdv?=
 =?utf-8?B?elhYa2ZTTEVBZFJpVGxyWGc3ZXNxNE43cm02T3BTZi9yejZzN3JEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3293CCBB6E862142901E5645F816756E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea18c10-046b-45ea-166f-08da1db0e8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 00:51:28.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrzvxFL3qdJuYVY1Tbzawb4ns+aneAq5+k+g3d7NdmVwVoWnHLVbPyzGzuhXVZe2p1td+LoeC2CNzxi9l47ZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3462
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=925
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140002
X-Proofpoint-GUID: 03dIehigQ3jHLPR5LBQe5bqLni8_DHGm
X-Proofpoint-ORIG-GUID: 03dIehigQ3jHLPR5LBQe5bqLni8_DHGm
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMS8yMDIyIDEwOjAyIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9u
LCBBcHIgMTEsIDIwMjIgYXQgMDk6NTc6MzZQTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0K
Pj4gU28gaG93IGFib3V0IGNoYW5nZSAnaW50IGZsYWdzJyB0byAnZW51bSBkYXhfYWNjZXNzX21v
ZGUgbW9kZScgd2hlcmUNCj4+IGRheF9hY2Nlc3NfbW9kZSBpczoNCj4+DQo+PiAvKioNCj4+ICAg
KiBlbnVtIGRheF9hY2Nlc3NfbW9kZSAtIG9wZXJhdGlvbmFsIG1vZGUgZm9yIGRheF9kaXJlY3Rf
YWNjZXNzKCkNCj4+ICAgKiBAREFYX0FDQ0VTUzogbm9taW5hbCBhY2Nlc3MsIGZhaWwgLyB0cmlt
IGFjY2VzcyBvbiBlbmNvdW50ZXJpbmcgcG9pc29uDQo+PiAgICogQERBWF9SRUNPVkVSWV9XUklU
RTogaWdub3JlIHBvaXNvbiBhbmQgcHJvdmlkZSBhIHBvaW50ZXIgc3VpdGFibGUNCj4+IGZvciB1
c2Ugd2l0aCBkYXhfcmVjb3Zlcnlfd3JpdGUoKQ0KPj4gICAqLw0KPj4gZW51bSBkYXhfYWNjZXNz
X21vZGUgew0KPj4gICAgICBEQVhfQUNDRVNTLA0KPj4gICAgICBEQVhfUkVDT1ZFUllfV1JJVEUs
DQo+PiB9Ow0KPj4NCj4+IFRoZW4gdGhlIGNvbnZlcnNpb25zIGxvb2sgbGlrZSB0aGlzOg0KPj4N
Cj4+ICAgLSAgICAgICByYyA9IGRheF9kaXJlY3RfYWNjZXNzKGl0ZXItPmlvbWFwLmRheF9kZXYs
IHBnb2ZmLCAxLCAma2FkZHIsIE5VTEwpOw0KPj4gICArICAgICAgIHJjID0gZGF4X2RpcmVjdF9h
Y2Nlc3MoaXRlci0+aW9tYXAuZGF4X2RldiwgcGdvZmYsIDEsDQo+PiBEQVhfQUNDRVNTLCAma2Fk
ZHIsIE5VTEwpOw0KPj4NCj4+IC4uLmFuZCB0aGVyZSdzIGxlc3MgY2hhbmNlIG9mIGNvbmZ1c2lv
biB3aXRoIHRoZSBAbnJfcGFnZXMgYXJndW1lbnQuDQo+IA0KPiBZZXMsIHRoaXMgbWlnaHQgYmUg
YSBsaXR0bGUgbmljZXIuDQoNCldpbGwgZG8uDQoNClRoYW5rcyENCi1qYW5lDQoNCg==
