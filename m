Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3724F6C4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 23:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiDFVOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 17:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiDFVNq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:13:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EE1C60E1;
        Wed,  6 Apr 2022 12:58:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236H47wG024505;
        Wed, 6 Apr 2022 19:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dtqhBrbJK8G8oRHbwjae+YIysmNKC7nlDmZJbF8H1no=;
 b=o5ZLDBYf0kWvbVOlxN7X06S7Q9miRZYEWBWKAdpsjmxvR7FewSbSLrOf1NuF3GXQIQOT
 MFrSYgpFTPgsqUwqquTQ/49/3Dgw5mUlqLM3SjY46Owx3vyjG/8/RH9Pwn6KAAJ+s9WW
 QbHG6kxGejqvDIgmuzMMScFhAiE/CZU95yGwGCnYF0OQRngp7FYuq6MHJdNAVIzfMeok
 XQg9np6oxvPNlRTXjnqQmyBNrb5oDsrYJsEyo+w9msCAqIk/3NlsXYix90xZMIkTz5Fz
 BsSUgumymOKTPtwtfwTm4ddHN0B+fkAQQTrOJZ/YvBgsI2bZi8Msjpa2kaIcdgZhOYGa Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1ta5a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 19:58:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236JtllX006896;
        Wed, 6 Apr 2022 19:58:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tsh9t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 19:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVx4Dv5X8h6+9lstAAr2hblxK1j5xuviZ08mEd0LuCS0eesdHz+CpjO5PqleL1CrZjiu67/xCJ7BdjvGkSDSlBWGchC09TJYYRPM639Sn/WAIjvhn4EQNbsq6cPlM1wKojHI5ypm8wH6xvfF08aVzxpGRy1h4adFSqWErKWvf+8HIyJDtDsJztf5tVjz0XVLdwNanQtkaNoQ+QykA1I9ndOgvtxJ35OjswuFvD3BDiYjAWef1WHSaq8+o14bjIDsvhnTAX1mDqed6KvtjjkX/ZENqlKVhRrNEY2F1y/ZkDWBXU1pfPTMOh13RqehMheL/Jzss5lkYNsz9UPBMXQiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtqhBrbJK8G8oRHbwjae+YIysmNKC7nlDmZJbF8H1no=;
 b=S68+gFfqcMEaLuMcg2QDvpgw+UYsi8hruN673+YtCPEYtDdo9T54385Q2m0qcR+Jc/bz8U7NszODQ6Ibd0iHRSQEpBRXoBmIJccbtZdcUky7LaoUQ+/RruHJ5iyDZ+WJNUKy1Z07acTZ470+mx8BM/WqphNGDd+b1Y1UrIM4wZ3/nIsz0qtBHN9XuTdmUrm+yqldxOrXpdsDQmJGdXOjnfRxqIXwat6qjvRqDfmp47tjXvq/BxpxGAjhhNV/h6XLHn6YIMhpAdVi00Ttfr0JUeYVqKCfmaNZV1zIj/3zS69tSv/h01lusv8F5rLEIdslg0bUbDR95incxxEWGYBohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtqhBrbJK8G8oRHbwjae+YIysmNKC7nlDmZJbF8H1no=;
 b=H2Yj3bY1OpEW642Ze/QdhFpdQ6qLgduUN6rwWDbVV+W7FM8BSSJ+eEpCSBYn9ifP/rXH9U9RUcBCFcxQ/xFER3kSOxojHjw59ecOeqYt1IV26pMTfw8zgoD8Do0BsG1VdOQ2v85QTgFlGVjVMq73eyV6UG6YO+U2Bz+sXiS/3Xk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM8PR10MB5430.namprd10.prod.outlook.com (2603:10b6:8:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 19:58:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 19:58:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: sporadic hangs on generic/186
Thread-Topic: sporadic hangs on generic/186
Thread-Index: AQHYSfAk+fU6Rrmkt0i0dk79TkMgR6zjTWiA
Date:   Wed, 6 Apr 2022 19:58:12 +0000
Message-ID: <9831571B-E597-48FE-9D48-06F971DCD860@oracle.com>
References: <20220406195424.GA1242@fieldses.org>
In-Reply-To: <20220406195424.GA1242@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f80eb7d-01ff-498e-51f5-08da1807c7ca
x-ms-traffictypediagnostic: DM8PR10MB5430:EE_
x-microsoft-antispam-prvs: <DM8PR10MB54303F23E8229423B902053693E79@DM8PR10MB5430.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: an4DhVlSSJGOYjV599t3KtTlSRkzvmv3AIFzU04dTcePc5J0SzKP02R1SM9dPwkR0rO2lktj576QoWahEUxW6D+ozhbROduPWtl9EOP/lO9tveczDmbyksjHDXeZo5MOhoNwv7ujjaXy14mUmitp+qhfHeOdyEUEg+uM9rBUN4Q4hgSzAIp8EcGI0hE5qDJZl8VqdsUaE8YFCHRkVdldEX5oc5p9il1eTxOue+q0LVU3lZTSW0KZ6fPprJUqXzGOozboFq7A7i0tEU48q3yBsGbIebT7fxsJyjuAre21dgdAY2Juu1oUMqhsP79oGtwSkmoOqw/9Zc0gOC94lufM9zqgT/RAvPvZKVARCKS+p1H71ug2ghkTay7ABrgYB/i+m0ryuXAsD+QE73VYesQCJak0mZGARkV03G+PfqGaM/Bmvl3VKCj9lQmXhHQIxDEKHS1ZvBTsiWmXLUF+tSolBztaXINhDHa6UbkFWjiZTI7JftFB5hta3/WsY/f41zl1RgeRwi92Zw3VaAl9cOduZ3quphNXz1+VL+aZ9FGEDrgz8fUoV7+BWis6R1pAToL2P7QaPsN7lwH+1lgYzGd3YxVLzrdUSGkaS5/PsEcYi2okRGrim1uvRqif2fSAjuW0D+MBA/cD4GC4X69PXmP2i+CcEnvlcNFtodRUJNGmzpgGNxnv8jQ5LY7XP4J+gkCiIb5XHxZOJkVPlZts7p3D3T+FOPq8RDik4YPxh4JdOpYx2Jz0g8JUvS6iqfCsnHkEOWNfeNhrhkNNfGWwTq4kHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(33656002)(26005)(6916009)(66556008)(38100700002)(54906003)(64756008)(76116006)(66946007)(83380400001)(66476007)(91956017)(2906002)(38070700005)(4326008)(2616005)(186003)(8676002)(66446008)(316002)(36756003)(6486002)(6506007)(508600001)(53546011)(8936002)(86362001)(6512007)(5660300002)(71200400001)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hVfX+lEyNiHYZ3BH0zQjdcWgU/TehKGXX8VfPJagpdxyR8kzDIzpMSmAQN0i?=
 =?us-ascii?Q?NouDAJZlh4g6Q1A8Y/0y5Vppv4drbv57hAnNI/s94ogGxIYonQbZcBH5JyNX?=
 =?us-ascii?Q?dHGTudpFjHkuAWhREuwmhoG3LsvkdIE7qTLigVi557KavnLH4zcy6ucye8Jd?=
 =?us-ascii?Q?C3ry3T1sHeApWcioP+Eb8Htj0S9GNR4q9mrV3VP6QmLuTFN305kpYnVTxcIN?=
 =?us-ascii?Q?8LXw7rstXfhAxl+2XIik9wSCyBIYhyucLIRx31U09hV9BNxo3Fvzpp141/Js?=
 =?us-ascii?Q?L7Sn4RrASPT8w1MFJytYR3fOBnZpmo4wNlpeJmm9yZElp67h+1Ki4r/cbcp3?=
 =?us-ascii?Q?XHPPDiTSLlQh8V9ExXhplD2kUhhY6CLLVE8LmrvUyV6S6OXxFil0lh0dAd0N?=
 =?us-ascii?Q?3yBL47lotcpZQKy+xKcb9CfPXaEiGfZSSwlfMu98D2N/QH5w83Qujg66Wssr?=
 =?us-ascii?Q?QM4rh8J3oQnvTRyp/LiSxlyawIv2l00SnEOFprjLtBRKhdEa6Pf3wo3ic31q?=
 =?us-ascii?Q?qcdU4Drg3vWqLGMxSRpejReVKVhzs5lgxyoVn6PwXNcZmQHqFpQCEZpsv4sF?=
 =?us-ascii?Q?0TxlF7LyJF0lLOxamDzmSsDMD4qQ5cY01XH9JibX3LUfKI56OOHuCpxF0Mpd?=
 =?us-ascii?Q?sQsiE5rLlxmOdivaDyoZHfBVe8KJKY4hv5m3dWHhaTgqLMq5CISgmdTckU67?=
 =?us-ascii?Q?l0mdvYN0/k2/zN6uaYbzZ5/XpTvTMmrB5L0mA48ETRNen2Fd2CtEVkYybcla?=
 =?us-ascii?Q?OtSaVzF1alJMhUOe6yDriOY3irwXy0I1y5DXRfM2n8GncRt5fOqsfkrGgqJr?=
 =?us-ascii?Q?0G9D54iowaw9UczxfcV/WMlQJhHVNJ+wcnMijsWV7m3EryIJ8Kq2OuUETNCm?=
 =?us-ascii?Q?GQsRr+feeZF7flfjbl8VP8gohT3aJ75P3dklqO0pieB3zfMpgl9EoOn7psDo?=
 =?us-ascii?Q?vSBrPhW4kPDoaCkTxx8ZtxzUKBkHTO9CSSkA+iWjDQmy8Q6URgAsS30aDfZ3?=
 =?us-ascii?Q?UaMyrFvW53mL/qDoNIdTm4FCSR/txSOdAg4zCUp5gPJ3TGy3i4hoXbovGPMP?=
 =?us-ascii?Q?OEHQ7YvLuXL55YsREDVMjBMG1shgVN3bVDOeLNbvYAtj6rT1kmhxUV0w3BOx?=
 =?us-ascii?Q?i6isLgy/iFg58bJ7foziin6cQMxIyLtzRRjzblNSPFYMk5w5W/gDJ8+MwpEX?=
 =?us-ascii?Q?A9qOoUu7ZgffiGVIaiDUNzVWCNyI7Z2bP0p+1S92jeknVHUVgeagAn/Wi2iM?=
 =?us-ascii?Q?1FQMugk4wU8FegQ4DriVEDIlyBg0t3unqMPias77JORKymNpyzIjiszHlWwX?=
 =?us-ascii?Q?Qgk4eJ++RiNozXriHcvzLg9394WqR1/OtC6JQHJY49s23+F+RbUZ0t4RQXem?=
 =?us-ascii?Q?SnT3rKi6LbNiM74fmZItcdu/SZbSc+7uVV3NkUf+bIN2U9AETcFLt5ztfd72?=
 =?us-ascii?Q?/iLHjK1zLys0P6UFnRUmm64DgQ6XpMFjpJdiG3Lun7sCNPLUZaQa5TK4BCi5?=
 =?us-ascii?Q?boCcFPZ9yVck2IwdhHKX9GrgvsXKDWgUCkgPdvPAs4r0SzCsxkOzyvCTCKea?=
 =?us-ascii?Q?1d37avkWOg0qnP61JrMIjSti6ZFnwINiPXPHSmg5xEU+/WbdzbNCfhyPrN47?=
 =?us-ascii?Q?XXHpCutaeZn8JcBYS2njl3Dx3/TmQ1iePd5EtalmWQlYBeH4GUvbL44NDflA?=
 =?us-ascii?Q?q8QWpAEPBJMOdWplTShKvlciZbJvdIeEkATYDMafaQ+i8UBuX6zwlOBnINFa?=
 =?us-ascii?Q?A25JS2fkAEXmhi/soGEXtIqi8/T5Gao=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5821F0FB56E8748BEED59D527C5EA9E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f80eb7d-01ff-498e-51f5-08da1807c7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 19:58:12.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRfQgsofbGKaJ5wPBjEnQQVcZuSklAQRO2fD+l8rcfusrGKA0AY7UD+ROIcAijZxTR4VbAoCw4cAjHYfQKHFnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5430
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060099
X-Proofpoint-ORIG-GUID: i9blOZGsYLgx86iGtmB1YY5yogsyATW6
X-Proofpoint-GUID: i9blOZGsYLgx86iGtmB1YY5yogsyATW6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 6, 2022, at 3:54 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> In the last couple days I've started getting hangs on xfstests
> generic/186 on upstream.  I also notice the test completes after 10+
> hours (usually it takes about 5 minutes).  Sometimes this is accompanied
> by "nfs: RPC call returned error 12" on the client.
>=20
> Test description is:
>=20
> # Ensuring that copy on write in buffered mode works when free space
> # is heavily fragmented.
> #   - Create two files
> #   - Reflink the odd blocks of the first file into a third file.
> #   - Reflink the even blocks of the second file into the third file.
> #   - Try to fragment the free space by allocating a huge file and
> #     punching out every other block.
> #   - CoW across the halfway mark.
> #   - Check that the files are now different where we say they're
> #   different.
>=20
> so maybe it's really some xfs change, I don't know.  Or maybe it's a
> problem with my particular test filesystem (which doesn't get recreated
> for each test run).
>=20
> The problem doesn't reproduce easily enough to bisect.
>=20
> I may just turn off that test for now.

Thanks for the report.

I don't have a SCRATCH_DEV so generic/186 isn't run on my systems.


--
Chuck Lever



