Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD24C2F03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 16:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiBXPJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 10:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiBXPJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:09:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B436199E02;
        Thu, 24 Feb 2022 07:08:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYaaP016939;
        Thu, 24 Feb 2022 15:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cKgZFMnr7zLIqT/NsE7r5i+SF88XqJpO54RNqjSzf9s=;
 b=H0WBJ7RPyPvfTrz11LSzKjnRjJj8GGbOdcJh1zcYeG/HV1jsfzn+ZEsapOY2K9qd/HJJ
 1jGZV53klcgYKvxbgSkmTHKpInI4DHDpXRKc8BDq6KqJzE/2XIxlIGVv6BvG0hZREFby
 qV6SMgp6Ue2XPV4PVz5w18YdIyVXpqtGGAVfnYLlCDWplvq08uI54dsjWLUSYOHmm6cS
 B/EHjznk4HZRi7QVkyrU2R2KTI3PYQWnPrtm04Ev6bbEWgLEVk8vBmpIPEXK86JRrEC5
 /hb+nK2UC8PndAm/JWQc8U3nC5VvJHUj9gmfhcj+h8mfwsCWmTCuCg/vVVoN5mqhWixg TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cqfg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:08:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF6wu9027462;
        Thu, 24 Feb 2022 15:08:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 3eat0qwre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXzgIbFH2bg1W8VLjJT/XD1R0WSoqkoM7efzdYPRvWPbIB4rHafu/Hn6JAI4ZzyUn8KXkvhXft/FQKDDqdsJMv1nCbNKxSoNKNHfANqJIdCTd7kLfefrz52gGsWCyC0kvpgl4lIiHDQ+ZX7jiGEIWC9o3TAQbWV7UGGEyuJ/OAjKZWX1KrbV1ooebRQLJMLNWDCRkTTrVLxKZ5e6B+3eMs48l8+ovojKeFN3vvR4rvhUYP4C599YXVirplk3B5TLDVJK/2hiV1puW4VBsBdsYTtB5JTJK2UVcL3T8kAU68aWo+aHeWBTCkI/Ks0MF+Wxiv+9WrrUMyRBLMWBDOeo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKgZFMnr7zLIqT/NsE7r5i+SF88XqJpO54RNqjSzf9s=;
 b=LgJBuePgdZ2hCkljxPA0iOweMcbpcfyC+0c1SQQeIIhlY2jYSupgEYOD/bpK0+jUeiP0nasMzfI4CfAlD4f6Y2fHYJntbNzd4IBhqnp1C84z8FN10qSDKmqofV51lyfd+dMKiRU9k/5pO3FrbiaMzcNy+KLNOEAKa/EMcWktat0Zcytm5heGscbSUkXXfsACiam067qvS/6BzgNGLLCM5IGq1S4C6fJD7KboRJxBrPjqJv9BaYuGultSQjf8d909oMwRvUvogeO4O5xzRetw1mHrVUUo3M3JclrWXPA3BC+elKas7+dy7Zy+A3hqIRmZn4qY34lvQylaoFQs9czTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKgZFMnr7zLIqT/NsE7r5i+SF88XqJpO54RNqjSzf9s=;
 b=jMc61HZE77jUf/JerauXCvDMtT+wgFhdo2h4lgSLMg+bZyrSY7Ai1N5GY7A6Asu4GygyRgoLALLjxnxbzcw28do5eFMEQ/PDyD4X1YKkGuE6aVfrloUslqo3aW3AoULZcSfTf8LDMCUxoUCcq2GINnrH+Mmz5tR4KMhlMg5oIJ8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:08:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 15:08:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Thread-Topic: linux-next: Tree for Feb 22 (NFSD_V2_ACL)
Thread-Index: AQHYKHvjd7nIQ/9dd0WHn6e/zlcx+qyhS2SAgAD35ICAAIyUAA==
Date:   Thu, 24 Feb 2022 15:08:44 +0000
Message-ID: <3CFFC488-CC2F-4B2B-9DD3-F939468A85C7@oracle.com>
References: <20220223014135.2764641-1-broonie@kernel.org>
 <5ef34a6f-c8ed-bb32-db24-050398c897a0@infradead.org>
 <EEADAF6A-04D6-42C8-9AAE-7D4EFB2FA507@oracle.com>
 <4820dc3e-6c4d-58f4-701a-784726f6c786@infradead.org>
In-Reply-To: <4820dc3e-6c4d-58f4-701a-784726f6c786@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43969507-0bf9-47b5-4e13-08d9f7a78d0c
x-ms-traffictypediagnostic: DS7PR10MB5037:EE_
x-microsoft-antispam-prvs: <DS7PR10MB50373969B3FFF2A6202E0D43933D9@DS7PR10MB5037.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIM29sv9lBEvsh9Lg5TxGqdc6QnrhXe87tnmPFdAsZ94i+CBishWMeu7EDjyt7pt2NlNK5qazlyxe57t58UnVo7G9o08o9TJli/ouzeAohrVGS+JYt1ROZ/S00yELbU1FYrnPqTdPWCSLfTfLlaCkobJCK4i3tV9/O28NyKJsIZgjKVFDV56Rcb9pARQc+9Zjz3ZSe8sDJa0929asnSrIpj91bpdX3iSx8kKVZHRI2cwFHaX3wJ2L8ZUNIrZKbwXsCfvVN7n1mZDS1RsetJB1Uq5P2cZ07PXeN80cABoSeDnAuM1CZq8fC0o5KIj/Efm53uEJMHJjZIJeYoMdOBLAGLFdUT+x/LjrgdRglwpGrtOoG8Cp5+Xk9van6PPVpS+h364dPTHMYljFDA1rAWjpAOZ9AbGUIVfcFG+weexH1a0311yNqXoeHFLgD7fLshQ3LgIN1O45IcIN9acWxCUEHbpXj12RdOFT+h1XC0qrBb1aK65zBgw1Ljt9FTvrqNxEuyTs3dO/9UoWYhG0Hdart91ds4omtYjS0fBVqg/HaAWpxs9BX3Crq0eYyYnB8NJCP6TQwpGsBar0Ep53Gsw+xfNPczd2sR6qm1csTASoICjOmgXdQG47eGi58X6sl4MecN7i5fgneDtKZ6tlWVn/nrypI44bB+dlTdg9hxqciETbeZDpwG/IPhLprKCQyanp4BiIbJ9xap4/h9nwQfhXVSOWL6z9CSqc4E5fZ2zInk/fYruBeL3AAhCHZ+idLM1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(83380400001)(36756003)(6506007)(2906002)(66446008)(4326008)(122000001)(91956017)(8676002)(64756008)(66476007)(66556008)(5660300002)(6916009)(38100700002)(54906003)(8936002)(508600001)(26005)(186003)(2616005)(316002)(33656002)(53546011)(6512007)(38070700005)(71200400001)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O3hcxyXDQMyCfE/2ZoMQoIRlIa8L4mcev+ha8xAl+zIJ2dD3dhAJiyE0nlG1?=
 =?us-ascii?Q?cT9Ui+Ny7xn+hY867XIy7UAcVJc7VSGpKkiOx0gEn97cBvCqvtXabmrAKRwO?=
 =?us-ascii?Q?nmTijAl/gUzTJUT1qj3rUW7j289pwVZm8uSvZWzz85QhtUeQhTD9ytSn6XD/?=
 =?us-ascii?Q?cGQb1Y98xnkBJ/HMp1rQfINLikynsSVTASGjKw7DytKLcogruleircqlPaTV?=
 =?us-ascii?Q?rRu8jMDp9hj8Vn/hKdEE6eNdac1EkmCmXKap8pO9cDoBxc5TFW0VsKFs6vnZ?=
 =?us-ascii?Q?syUCBTi9UgSzkEDjyK6QT2A7Btm83ZoqHyCt6zJglQyQRBfmyOhQJ08KnKt4?=
 =?us-ascii?Q?45eSYVY7QJ27bwX6fjQvn5H9jU8mUYmKagURMtjwaxZCCX1phECtqTo33Khk?=
 =?us-ascii?Q?1jNY+wduaa/Q6Ul+YS6ryqNpYULCE5ZJMLBTUCjBCarvONIxFJtS+Js7wokk?=
 =?us-ascii?Q?+FxrZrQvNrMlLCcTZN351bINzo7Aoo8Qu7/HXYvLxgXaZwSwD4Jc/bp0PfFg?=
 =?us-ascii?Q?8pbGhNTxfwBA4VvLrkjqsk3keJh1WqgztiQk/F/n0AO0N8bVrgpyW1F+y+VN?=
 =?us-ascii?Q?FrUsM+5zb9P2q/ndwDoZ4iFx210VIKFmKLeTRAC25aIutKv6f4j0W9nN75Ba?=
 =?us-ascii?Q?Q/+khz3oqjx+xonU8BEtbDDwmWltKKXCrsACf5nnto2JdK9lI7NvHi1FI4lq?=
 =?us-ascii?Q?B40Xyl+OdqOTVPLVMnnB1RNe5K3XaBY4lxZHmsPBE7Slg4JlSFvNB8LcBQ4G?=
 =?us-ascii?Q?iiZdDsd7DuPn/iT6FjEHt1TH2dmMegsxirjbPes+iv7xPvwk6B4JWJQxJfqW?=
 =?us-ascii?Q?NRlZab9aB85/AxrzKf81oT80cNBwGIOjj+s437gFPg+7/cDW1X9JOKcpap6x?=
 =?us-ascii?Q?jG7mzNoJk5MLWOAZGEPvdlqUFwZRjbA+ZSDu0fZ40Wh0N2ReIAfnZIXw2BPE?=
 =?us-ascii?Q?jxypfPFqNKbGEAYqq902xtKY/qoes3atuHnV3m5o+x4rMGGeqlr25MdauP9a?=
 =?us-ascii?Q?2p3P636EIWTpOWsklq6QV01jE0xtLKHj2ikF3hF53Fj+nMXYjVHZtXy4HUTf?=
 =?us-ascii?Q?pi4IGQJKEEJi31t2+CwOXBjsahuIJckM2iS/RG6zb17m25JxFEWrIzMpALVm?=
 =?us-ascii?Q?fwMlrAzAl/SF/KZhq1EM7kIy2OSoTJX+fs3qR3vqYIrME2b9E3VTda+o1eBN?=
 =?us-ascii?Q?pn+qcV3lPv0xgKHyA6t8IRuKK2PGrXGcZcxqt6DKJM6v+bZsphe/Z8W+W6/p?=
 =?us-ascii?Q?BGVy2M2Nqi7MIcz6y9//+VCbkpLLZDrdN2OdPCPE8/Gl+K5k4MRuhvOoKvOQ?=
 =?us-ascii?Q?tUomQf01oum+K9VtIEUNXQWep10ngMEtAL8uyhmMqA12Za/zBWk657MwDEfJ?=
 =?us-ascii?Q?ODMN7tMMw7W4y8A7514IPqnpU3DEkNB2VDqo/S6l0XTCbhNdiD89V6J2i95h?=
 =?us-ascii?Q?HeWQZ9Cs2dLszTChadXhJNPZX2b5NoGx45c42r/EL0qJzTLWyJoiVYTWZNlN?=
 =?us-ascii?Q?I0X6d18mLLbmXphneQkEsSRuX9oG/nn5RYVNaFGsPuz4t1CjGLgn4yWNADpV?=
 =?us-ascii?Q?Jemv2kySl3qQcOK/jz45nor84JHuJsAjHFEE51LHGSt6aQzBl3xx+qGQmiAh?=
 =?us-ascii?Q?KNHxgbgfiSDk5lY6KdAOXYY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DCB19060203054A87E2F584078AC404@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43969507-0bf9-47b5-4e13-08d9f7a78d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 15:08:44.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGejsglWmNkDms/hyImDW4DMxLG0zMNU4scNp6DJcUaC4yp1381NEF91XmNxoYJPMaCb/y2Qv1klCmD/fRtGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240091
X-Proofpoint-ORIG-GUID: q8dASpfBrT1jRPhxCMFWobzksY23-XcE
X-Proofpoint-GUID: q8dASpfBrT1jRPhxCMFWobzksY23-XcE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 24, 2022, at 1:45 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
>=20
>=20
> On 2/23/22 07:58, Chuck Lever III wrote:
>>=20
>>> On Feb 23, 2022, at 1:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote=
:
>>>=20
>>> On 2/22/22 17:41, broonie@kernel.org wrote:
>>>> Hi all,
>>>>=20
>>>> Note that today's -next does not include the akpm tree since it's been=
 a
>>>> long day and the conflicts seemed more than it was wise for me to
>>>> attempt at this point.  I'll have another go tomorrow but no guarantee=
s.
>>>>=20
>>>> Changes since 20220217:
>>>=20
>>> on x86_64:
>>>=20
>>> WARNING: unmet direct dependencies detected for NFSD_V2_ACL
>>> Depends on [n]: NETWORK_FILESYSTEMS [=3Dy] && NFSD [=3Dn]
>>> Selected by [y]:
>>> - NFSD_V3_ACL [=3Dy] && NETWORK_FILESYSTEMS [=3Dy]
>>=20
>> Thanks, Randy. I think I've got it addressed in my for-next.
>=20
> Hi Chuck,
>=20
> I'm still seeing this in next-20220223...

I tested my fixed version of the commit with the randconfig
you attached to yesterday's email. Do you see this in
fs/nfsd/Kconfig from next-20220223 ?

config NFSD_V2_ACL
        bool
        depends on NFSD

config NFSD_V3_ACL
        bool "NFS server support for the NFSv3 ACL protocol extension"
        depends on NFSD
        select NFSD_V2_ACL
        help

--
Chuck Lever



