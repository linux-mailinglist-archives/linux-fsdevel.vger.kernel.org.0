Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152B6515132
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379355AbiD2RAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiD2Q77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:59:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF43192A;
        Fri, 29 Apr 2022 09:56:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEgigw032179;
        Fri, 29 Apr 2022 16:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P8K+3JcciMfHNr47KLEX6blS1+yobM4rF3NIxT5BW7Y=;
 b=0kuTdqVT+qTciqp7QEoYzyLR0VZTNXvG5Rw1OSWUw5MhsU0k0ZuV2IleqFlrkLlLbyn8
 krHR48ciM+PtrlKUci3lbwN86QbKvgeMVpAXPi/3gn9TXoWXZs6/PRLklhlMQYG50Qwg
 UFfTT5p2omj1YF3iV/BPh899fBYxsM+HfpH4eGFkT62wA3SRAYRMWf/x6+HOIHA4gZrS
 tkDQqjcHhAk17rR003Tpqv4op1IuhQZvMMA3O9pSpYTdlCy1pM00/my5s2SFX+cYiRsX
 R+t6XWqHrYVgv9C/G3MR5ZfzDGGxaWM6edxHwFwuLuieraggLvND6/Gs8e20ObepEJeo Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb106mqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 16:56:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TGVUi6018850;
        Fri, 29 Apr 2022 16:56:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w89d9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 16:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt+K8H7xsU1N/wEfpmqeDNcudIAADE9Tr5mbOG9GK1pBqS+xB+4h/0Mjf8ve2ogCCvEWLzobRr9P6M7bC1Suo8WBvgudhOyYP9qfipS/xIWtW9UbqqD+HIq2IUJnWqLUTRRYoD2eXMJ96EXV1qYfvWXRBPA6/Oi7hWEXanzwq63XuE6Up4Id4Uxmdu+hgF23KvxB7Y5bNvkMjIepj/o2q7iKJiw2H2B10IaxfoTZLTLT6tzy2SUliNUgh843xsZuobL3LReX+s8yIlrYSa79OMPQxs7TOriKsZC8sY8D1HVLA722hIr8hQSeSGTtIno1fmlNr0zAbmF2YxLqP+nuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8K+3JcciMfHNr47KLEX6blS1+yobM4rF3NIxT5BW7Y=;
 b=EK494BeCQA4wipZo7upOPq98w8Gj9+mroLy0uas3zz/oHquUVaCmeWn5OPdScpXhEjchiVza6otu0aybM9aHZlNF5EGObq83Y/daYqVSsHNMDrfMc23npZE9lo3cfVqBIrXZUuhkqI2e3tKVSZrWqFboTdP73EEU64P67InhopTpiwY/Q9TgLnED8hn0Nw7sGJh14ekEsdebCYy6k4MKNmDG2cDWM/OOtN3PZbNkCX9VnBZgh9fmbRTc/kIXgvgtmHpwyWxegt3OMVFLEFfaLgNaJbL3PFApUTXsbpYocvuc6r/EFm6wHclWhK61+C6oBFCqjTI8nL2XAKrz6W2c3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8K+3JcciMfHNr47KLEX6blS1+yobM4rF3NIxT5BW7Y=;
 b=e4NBzhzaYhL3rPe0i5J0w57wQClCfORFjfGAtsOmvACo8HrCemwZMERBoDP3XsfU+5YWzK+bZI7pECYDEiinuBp6IEU41v8TlOfVYGtt92lDPKI71j84gQUMeVcaK++uV5cZsBpLQnVEG5HWuPAOtDEfyY1Qsq/O/bLIlAyyDkM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5410.namprd10.prod.outlook.com (2603:10b6:303:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 16:56:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 16:56:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v23 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v23 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYWs6CPuCkiaNLVUqe4GH4xweRu60HBTwAgAAZTYA=
Date:   Fri, 29 Apr 2022 16:56:32 +0000
Message-ID: <05A3D378-8A1A-4F3E-A1BD-4DEC1F5A9F2F@oracle.com>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <20220429152558.GG7107@fieldses.org>
In-Reply-To: <20220429152558.GG7107@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdd4a8b7-c270-4612-c6d5-08da2a0136b3
x-ms-traffictypediagnostic: CO6PR10MB5410:EE_
x-microsoft-antispam-prvs: <CO6PR10MB541029117BED82E491ECE22493FC9@CO6PR10MB5410.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uA+dwOJ1GmApZkHjZ/VLnK9iGjKvruqD1W0X9lFGEA8KDtcaOk6EMlhqBMlkmo4Tjdotk1mwRhUOovgeC8BL5yh+0Fs96ue3+EwPba9IdYPkAz1tLlfJqCkIfxlFrcNKcsZjOemZ12rwJcmyRX0NJGq6jlBYuk3+goLq5Go0TYTupbbA4mVGA6l8t0mFi67B7hL032pvbFry8UoU4P7N0BJqDkw3sSQz+9iscvd3Iwodd+L3y9feRXCxmAcw2aFv7Q0rrqJqBP57bGx+MhNMfwKYrOp1F1YRB9IFbhxp5PHe1UFtMP0Ryq/oMCNsn4l6aFumWsRivwMaqH7k3x4i6+27uhBDUrzIkCXVrA6M5xzyc/yQFbVm/BpWPqzurcd0lgwRvEzkE/hWIQ9wMt/xkQY6/JUXUODyTb78uMCSp6v42NbQ1VKGrIma+Ke16GBnG6ERd922WGq4lYH0sO/9+drOAFSKFTzCVaP9n0Ffi0tcYD9eVo4Wb6513+7zdE/DnPXPlfld0nAB9JSaZJb+3N2qOrAhv1MmFeiqy48UsZN/PaeBrwHhATEIFMWtTOgEBSqGcRkMYWQAAIltdsH/bt6TWI0uW08R0Lkqb0OE7mz3OEnY6El6ZWvAAHbvacdz7bS3FY4gH3HgLiUnULcXNS8BMqwyMg1JIodByS7ErXvXq8tqjSfgAJHgIFF2lXrOVva75hZFCRwCcEqRfWW3PXAJEWKlKaQyBFUYNKSXEwsgkoGWGPDxNoB4CsF6Dskq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2616005)(2906002)(86362001)(186003)(5660300002)(316002)(122000001)(33656002)(53546011)(6506007)(6512007)(26005)(4744005)(91956017)(76116006)(8936002)(4326008)(38100700002)(8676002)(38070700005)(6916009)(54906003)(66556008)(66446008)(66476007)(66946007)(71200400001)(6486002)(508600001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?isVlPzSNzA4kOizUpTXWBgFHSk3NP8pnGksjXu9fmBXnZm8BvMVXx+glGtjZ?=
 =?us-ascii?Q?DpI2bbDiopboRg6Z2tQaDNqx0f9ESoH3WU0kTVH04x42xznE7LkAXlX6AifJ?=
 =?us-ascii?Q?YwaJEtkNWMWd84kZtFKY8cdz19qzu4n+I/dwmXv3Q5v7HLaKdczZpUuVote2?=
 =?us-ascii?Q?0RvpeULwLYXGAZjFR7zFuWo9XB5HGRS1BmFoepoLpGFAEDy0SueGY0rP7QiT?=
 =?us-ascii?Q?gLJmp08YfGOxH5Y6SgIbaIkupaQKwV/bWciUFwP2yVTr0EPw2uNhjc2U2aDS?=
 =?us-ascii?Q?ddDzlRvKlD+nHCUM5czt8Y74AeiOWSl8s/8/K+T3XQ4OmGG155lyerOLMqmX?=
 =?us-ascii?Q?kSDYi98P3JD03lr5IvZwrerORgdZs5mNFdpJEQuGYGDtlYC4e8QaJGB10HJ0?=
 =?us-ascii?Q?JPCUbfhX9tcVZ0FMhO+5DohJ9E9Do6DW86xyfkTYVbX0t0lSHGM1WL80lEmG?=
 =?us-ascii?Q?/PR3588ppT+u2U6fVupmpAMV5hKTiSHysvLj8t8h+MmTYkBgbPWiltHdfPGU?=
 =?us-ascii?Q?NVmjR8ZCbROddCns89JGwQ9oB9I8Jjw05c1wimKU+eeaBYUOx0+CVJZ11q0x?=
 =?us-ascii?Q?Efp4tdrHYL9U2lPhNaBMkYgLCExv0W+T7Dtl0R/8Jf/S0ClyIVfYdsqRn5DV?=
 =?us-ascii?Q?cun5N38lpudOTxFBTeggw3V5RamQzUdUWfyEIFZ4NgBQsqRGMi/nNjUNHVda?=
 =?us-ascii?Q?iG4SK1KLadqrmWKPvCrWS82pi51IKsM9spF01l3hXXJSJ1Y19BToFTjVR1H6?=
 =?us-ascii?Q?b/gsZfwPvNtzRHBMbD7hnmZTSSPFlWu72Xbv14rhOZWeeyjMqDgmol084V2f?=
 =?us-ascii?Q?6kiyj6RureSif6XL3wiV/pcJJHLmtJyXurDtyOfLxGgGSaihrJzmvObnY3cp?=
 =?us-ascii?Q?WeQc3ulM6pdO59hNu7wXbdWCruKloc7H2D76svO2BMpax1QP75I+W4FYdyn0?=
 =?us-ascii?Q?kyl80scN/NorRbosFNW4bUTZw1SCVV8cooZk4CwMGfJW3ykUwOTBAhaRUCqP?=
 =?us-ascii?Q?QldwMjVbfzR4u9gbjW+xjml2XhTUbVcv/zfEvPNOcRe1Qv7tBJ3hafOfgJqL?=
 =?us-ascii?Q?poOvOBmZg8OgILtng+jrCP7AKKujIlrE2JNWfz6BAvxJLeDZPwglIhj/kRXL?=
 =?us-ascii?Q?1lgBOVxp8bX/HV5jXmxOymzxqNGe4XxWsNrJxChlM3ZNrvHdYmOYc0AWLJEs?=
 =?us-ascii?Q?Qq6nwKs5XAvzzXLHzXGmtayoyuCx1mykMq9uJPa5muDlJHEYByhzSlYAyEgf?=
 =?us-ascii?Q?3YjAxgjqk3PSY8s3QN6HD64fUjWIpB/Sr3DXJnkK4M+peMzuPD+eMOUUGHgC?=
 =?us-ascii?Q?Blyw6vXcAV1iNXSxR/8Pzp2Oyge4P+WYfGROOvCLSRPY7nMu+raqQRwwxpEM?=
 =?us-ascii?Q?u2h73R1nUIHDxPeStChPG4Z82G5UqbbMU/0HozdlLEcyRN3+IAPyucKVBs+F?=
 =?us-ascii?Q?rRsTV+qvKjdDIrLgygDGfYJXD/GhUdyG+jE0VylSDITI7cBA/81CR54U4lV/?=
 =?us-ascii?Q?g8fIOvocvKcOx4Sq774UOpSj+mwi7G/tsmaqwKbvvzf58MsOlVBJZCWZ1qyE?=
 =?us-ascii?Q?bMuZPxiG532q4tYsmZvQeD7YTy0E9c6DS0Nzt0gx1Ye/iOHXSYD8y0LnTMQ2?=
 =?us-ascii?Q?+sKs7p9RODMo27VFspq3zCn1rpMtvDgnimK6FcOBIdbDDjpOrDLy6fVbn5ek?=
 =?us-ascii?Q?ugnzRR5dySeeWgIocsr+QDSc/AcTe6j/TkP97VMiCtRpVkkBwYspMrvfOV4E?=
 =?us-ascii?Q?NulyWFG2LGNS1L3xPUIxj2CXxU74nNU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <920250779A28B442B8A37CDA4D38DC81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd4a8b7-c270-4612-c6d5-08da2a0136b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 16:56:32.6799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJ7st3SG9mmghhYVJwqtkcK9JP+lslNU8ms6PCVwrg+2viW2mpCU3y9CAaCR++jjJdGSBXEspDuSnX62uSurkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5410
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=992
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290086
X-Proofpoint-ORIG-GUID: oRjawDanv0-9bOipgsbTtiZ7gJi1XSBm
X-Proofpoint-GUID: oRjawDanv0-9bOipgsbTtiZ7gJi1XSBm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 29, 2022, at 11:25 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> Except for comments on particular patches, this looks ready as far as
> I'm concerned.

I propose Dai should post a v24 with suggested corrections. Bruce,
please send a public Reviewed-by: to that version, and then I'll
apply it to NFSD for-next.

Thanks to you both for your very focused efforts. I'm excited for
Linux NFSD to have this functionality.


--
Chuck Lever



