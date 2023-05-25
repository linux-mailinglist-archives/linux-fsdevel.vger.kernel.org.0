Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D77111F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjEYRVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjEYRVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:21:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B00195;
        Thu, 25 May 2023 10:21:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PH5UfK025098;
        Thu, 25 May 2023 17:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bDLpPTokrnRhRoVy3UnL1Rmrxm+EpJT0XGW8ET2Z7a0=;
 b=wZsOJOTtb2t22oP0BMOmKGwWsxlAtmY2X7vpskn8fvSnB4vbUVJdE9enA4bQPlVvplfa
 AbzfxUs4pH7gcNr+8bZ1KAlCLXgKPg2xt/QXjfBj2Wie6IIWwlROrvzTIqxqywObotwr
 iVgxT0quF3L3WJha9pVRZ6Geg+leJ5QBAJmWuYDCfu7OX+oLtEmlapOS4KfVThuldk3n
 LeK9MA4Rws3fDsUpU9rYLpPrORw9WlGpiF1FhoHRIZKpti9LBlZXQfBSXUgGq2pH28wZ
 WbjOFSi1afyKpCWD+FAR68Z82hFPKTM6vUdDek3pLqeXeO8uovX8OI2w1Gj9C+gp6VXa Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qtbru01vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 17:21:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34PHAnet015864;
        Thu, 25 May 2023 17:21:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6nf5yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 17:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg1/CH+lJAc2u7kifkcZWdXJZs1i6KZvijouK90E44Xg0n4QfCJV5vNTzgvVtx4jNVcn8dgPT6lkZq2FqEiU5tVObTEdh0AvYW3rpBJ4iu7Eijh6q7qvzgqp8QufxmyrkdwYs2VCHu0U0fL09O2Ggt75JPcj2xBSqgF6p386OWuHUlrQ2myLx8dgHtaAwl1MGHO6rvILcBDZpJE9XAaW4jemxSsvoUebEoFpTyov8E5xwp+E6JuVdX9nTXLZxXUehIBcgv2fG4DxVbWY+tP+OnHDfZjN/cK5qWWbKgl6YK1Wotu0esphwEOfnnIfkxhhLxjSYlCQXssnOpufJnvmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDLpPTokrnRhRoVy3UnL1Rmrxm+EpJT0XGW8ET2Z7a0=;
 b=TUlV5+/qlRIC5LtFRxJN+xo+z128E5e4DPc9oU7onOdbG7vrEg8A3oWlofEP6VcCpO8RLb9CwmeBZMqAm4ey7OpBjR4sQrEx9A9KtRfY10FbtboGhlkluzrs75t+uUGJIblDgodyTmwTBF11T1Sq9xmjn47cOmj0dS3iy8wDour+LKU39oyMZaOMKlbttpe+mwf5zS6bSEJGqJlSaBpY200PIiHwT5Q5hvQ/6j4+nAz7CSpawv8/Au2/2cGGwxlPhIfmoD24+GLTPrXBY586OQqncfRwAe229+Hl4C0myz+r6Nr8QemE6vDWuhilqVamN2M/99bh+VbSapy38RqhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDLpPTokrnRhRoVy3UnL1Rmrxm+EpJT0XGW8ET2Z7a0=;
 b=wxV/+NU36mO9Glo8lteeLMTPDqCqb4tat2988DcXc3ljFptkxaaBfFKoBjqTbr6oAmPkB4lvjj22qCWr9ZtfdCtmt7BZa9xEv4IDqhZ5EMxO1PvAk6jJGlmVEcl/ZRy7aOOyzEERin5ymBPmn11ZrnLh8QivVuQvhIVZgRYPUrk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7132.namprd10.prod.outlook.com (2603:10b6:8:ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 17:21:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 17:21:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
Thread-Topic: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
Thread-Index: AQHZjQiHYb+9V1yj3kqcohFaOFOV+a9piOSAgAAtP4CAAYpwAA==
Date:   Thu, 25 May 2023 17:21:30 +0000
Message-ID: <7A5BD9CE-5592-41C4-8C48-D7E489C59C37@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
 <33ffcd5fd5d794fb642bbabf93f34a61d2f0d4e9.camel@kernel.org>
 <58191055-96c8-d693-bbec-2081b1bc5a75@oracle.com>
In-Reply-To: <58191055-96c8-d693-bbec-2081b1bc5a75@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB7132:EE_
x-ms-office365-filtering-correlation-id: 98564b20-637d-49ad-9bb0-08db5d447b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIYf4gVGNEzKSGbBYHc3QuPo0sVAIVYmwA+lzsJN4aZfB9KkdDQrcHS7+hwypNVUu5L5eqz/eMU8YbROF5J9yElsrO1MhBXmaaRMYptNZqagWBmSFtQQC0LMARbQHKsXH7Gm033Jdw0G1iOzZCoGhwFIgwgZHOnh7nJW1CHJqMFNUCtW3nu+W1hn7IVnNkH/7Lp03Orab3tK/32Bi64PYeXldQzJI5PoivhVsbZWASFSlRHmBc6mwwNBR22yhiHboEpWU68rd/QqF5ChxvcMTcoC4oBxBfMhYvi/hfHud2Fqalo8zHbimfwxUKzRk82KHsYySWy/ZOjw2yNjSbV9vrupPptLh3Bbxby11gXmJ6dLrhYlQCqVTAaJBiFiHdZap/OKRbFdLhUxEoyrCzgDpVyZ3GkahzdtNjVRpivV+XrwB1S2OrC0Eu2kTMxarlBaoU5U5LSECStAeMacwkobI6ecqyZ7+jcnDNpOEir67/LfARdNUah9SjPZX5hJ22Utno8VMTFN4qzSgBfW0cvQvUnybspLjCqU67Jp59t8ZeeizUYpeNmMLjKenAEzHwRfCsknBP5jQNhhoJ6Kg5jV5FccpGvMKJxhmu4PJ/4mR7BTzlY6fEnAhpW2/wQbhrPmWEgTCCxjLS3n2g9avBfeBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(2616005)(83380400001)(2906002)(186003)(36756003)(86362001)(33656002)(38070700005)(122000001)(38100700002)(91956017)(66946007)(76116006)(66556008)(5660300002)(64756008)(66446008)(66476007)(6636002)(4326008)(71200400001)(316002)(41300700001)(6486002)(54906003)(6862004)(8936002)(37006003)(26005)(8676002)(6506007)(6512007)(53546011)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VKi0LIdfW4CBrYIcBawd9dxu/mKrQlPeW8MyVcF5/cIPsaVzxVfiXtDn2VJU?=
 =?us-ascii?Q?37+bFnaLx0Y4dsYB0Qv7UIHX4yZAMcPhk9G9312QJGWKjn9a2aamCdjeZ+h2?=
 =?us-ascii?Q?bZjlQPaeemUM+vOo9T2xwbJkh0NB5seq2JtI1arzFmxyzbiMaF/Cqi4CG972?=
 =?us-ascii?Q?7G4Sre8JnJ8PfpzLCeRU4u1gYhd/8nQw09FLx+IvLSUiE4Z8ucilpGbSGUlt?=
 =?us-ascii?Q?9SVWvk4X/mj8kLLv0uMJ9iuUqVFrHNUJqPEOD9M0xp7umcT0ampDyKNqA0Am?=
 =?us-ascii?Q?VFJAHQklcm9VIJERTdWWfmW/752swpfsDO8YildmCYXDH9hh3SzaGw0QWMQx?=
 =?us-ascii?Q?1ojaUn0cwodCRU7shvwZmPVZjIBCEAfFGOOlfvzleT5Y8q5oQfzVTg0ZIxDu?=
 =?us-ascii?Q?sjRhp/MDpzdshuFoOwmCCnNakei514tGkkWsmv5CW2E4CW4PmUGDJBdU7NOY?=
 =?us-ascii?Q?ftFDYTpd/F1/X5LqPeycjbptdOOIvX5HjSF5dlZ7K5sXcKJgpTA9JRaToIA0?=
 =?us-ascii?Q?KVaYdTzPkTZ+FSz2F9KK/N4getF+XuQwqQzn1eGggPlEJYUgO6KmymDGC9o2?=
 =?us-ascii?Q?eJNsJfLfQCO+94EwSrx4A4M75OLZ61X0mWtKQ15WmQMVLQ8qYztflaDBdu31?=
 =?us-ascii?Q?abk72fF+2IJ+iIoVPX4r1keTSmHouVd9TK1RmXg8NESr7CRiBgdCWG32sE1h?=
 =?us-ascii?Q?rkUZwe2C+m0dPtKmIX4vm8VQCc2cvpBVzh5zaB7HAYNMCoxg/57Jfvuzdpin?=
 =?us-ascii?Q?OBnEgXIVJSigTS5+1hqkh3Vf6LtML8wWu4LmxEJ6ymIZByv8oDoiZFe0goDY?=
 =?us-ascii?Q?JCiom23RtNlqJM3qxCfgMDGbDcsscjJIEnVCpULUSnF3WgF8JXj3Zf0advyO?=
 =?us-ascii?Q?nl62SKR3onAr13qKSexS65Fsx8RrhzKkHA5fNRh8bYqK6Esbjini16krzb48?=
 =?us-ascii?Q?pA75Kl/a4YzZY7h1AWKGFH61wsR7woJ2CGpNVNDe0OUXXTKjWDen1SMgT1i8?=
 =?us-ascii?Q?vFxBRn8Li9yKrUwXX9AlNUJ2fUPmftZTk0OhBlUM9nMD1qmZ+YZYzfdSjFyG?=
 =?us-ascii?Q?DpvRXPi6s5SfMyCXR73C7G4iRa54RqNdlar/q7zXNLRfrcjGG9kF1hk4NyqA?=
 =?us-ascii?Q?ZpiYJgGmcgqxNcc2Vw8Ro0DLur0/FvdCs2MOdNhQn9IkF/p7i5pTOZuPtaSa?=
 =?us-ascii?Q?YH5uMmckXmDKO6bbyBK6JZiEqbhksJJKqZtKlQ6ulPO+1r492U35L2h9jbsM?=
 =?us-ascii?Q?UKz4VTa8HYdFc69HKs8KiPuRGIXiqDDOUiQ18ZYa1c/x7Wkfa6piNOfnfun7?=
 =?us-ascii?Q?vYGeyrFYqX4y0o5GLJj3dv+tlgz6ZfUCDnsb0spyru0bxY1Wt//2sZ4oJjoF?=
 =?us-ascii?Q?F66WyRszhRVi4ZUrIsCyb+tkFchPlnhiitRLzNnSj8Btcwm+2ebFxvIdAvO4?=
 =?us-ascii?Q?yDeUS0wwti5AKBHgI8WrmSAEbbJKbFg9QIjbUXVmeHLL5GQuMpXp24BD4r0v?=
 =?us-ascii?Q?IBBmrQI0TNA+4XAnb2cW9TrB6mYbM8LNjTNYJygIR5oAVDfwlJKtONwFtXtL?=
 =?us-ascii?Q?JUiJnGhWHZccmKzaGtJf4tUXW8YA6bssvX/jdxG9hvuGEXy3HjGwVwzCypwD?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6403EFD8735F68419097687DD06F143F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FLX+voeJDLMYuJjA1usSPZOTWQY+D5p2uOi8DfEkcSjJkQEiH94hvnvhVnIRQBP+S1IhJBOaCOYBmFN/wwh5/2j2ez8MtTbqCd1ovI/BvLn8/L7rtvzDUW470l8cSuZrdKoLi7l4+Plo0xxGfnDGsifYyo26frnUBGRw1toqjIaK2buq3ntKEZNNXLWI/UTmnW/IMwhGb5QeWvH92E6hlWvwpS5+2otoSQFBk6kk7dOIlhTT+uycXPaKlvdEMpgsBz0xltaxZM+nzserGLx4cqgvaeEPHoXb5BXcMXFLgPtmIKTwljzDjejw+0LwYg15unTN+8Rs+fqsE49Pe1RtuA8piM+ZmTt/3H9xFMGKAJFDbU8lRiTeN1g8Bx1AUTjShkcJQdOPkQuIK8kw9/5OJySmCVszowDPiIW+8YDxQfqYxoNhURhUqJoIAeOR+zvh816DDkdd2D7gNWnneQNVQyN6f5THlQCxn+GNVWUSschQajq+PKZG981Ie54+orHS/UFNXURCv6PMb2T4lNs2LtezXfCbWiKNMD7wS+YgqHrycdkk9m9wMMLKp2bMsCg7bZRWdNipge50wbR5uyODjsuYk7lz/qr7uAvo0tFzsXyJAbAVs9WmBrofwdOfQE9ByaM4FslbSnWAd8bdHZC/f+qenIc1+7yPC0fozynpWmxdpvPwW8LPDgO6032BsRP6DVq/yvjpNHqJ69SK1cqqg+KbM6aKvPjOZTLxzBgIXGmFzBpQ4hQANDnzMNYz/IaONCBbIrXi+3p8WAe2zsQfmUuZ3KaPBggF72pXzTAQHW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98564b20-637d-49ad-9bb0-08db5d447b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 17:21:30.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9hnrEMCd/3c2bGxt8+EQDQXu9pqvKLZjwAKLtlxnuC71Rpfd+jJtJ+kMcsKkzgVHNxejaZTJ/lVibyTvH2G/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_10,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250144
X-Proofpoint-GUID: WDvQ4LyF7U-m_B14TDH92o6_DwECJ3y8
X-Proofpoint-ORIG-GUID: WDvQ4LyF7U-m_B14TDH92o6_DwECJ3y8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 24, 2023, at 1:49 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 5/24/23 8:07 AM, Jeff Layton wrote:
>> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>>> If the GETATTR request on a file that has write delegation in effect
>>> and the request attributes include the change info and size attribute
>>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>>> for the GETATTR.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>  fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  fs/nfsd/nfs4xdr.c   |  5 +++++
>>>  fs/nfsd/state.h     |  3 +++
>>>  3 files changed, 45 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index b90b74a5e66e..ea9cd781db5f 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -8353,3 +8353,40 @@ nfsd4_get_writestateid(struct nfsd4_compound_sta=
te *cstate,
>>>  {
>>>   get_stateid(cstate, &u->write.wr_stateid);
>>>  }
>>> +
>>> +__be32
>>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *ino=
de)
>>> +{
>>> + struct file_lock_context *ctx;
>>> + struct file_lock *fl;
>>> + struct nfs4_delegation *dp;
>>> +
>>> + ctx =3D locks_inode_context(inode);
>>> + if (!ctx)
>>> + return 0;
>>> + spin_lock(&ctx->flc_lock);
>>> + list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>>> + if (fl->fl_flags =3D=3D FL_LAYOUT ||
>>> + fl->fl_lmops !=3D &nfsd_lease_mng_ops)
>>> + continue;
>>> + if (fl->fl_type =3D=3D F_WRLCK) {
>>> + dp =3D fl->fl_owner;
>>> + /*
>>> +  * increment the sc_count to prevent the delegation to
>>> +  * be freed while sending the CB_RECALL. The refcount is
>>> +  * decremented by nfs4_put_stid in nfsd4_cb_recall_release
>>> +  * after the request was sent.
>>> +  */
>>> + if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker) ||
>>> + !refcount_inc_not_zero(&dp->dl_stid.sc_count)) {
>> I still don't get why you're incrementing the refcount of this stateid.
>> At this point, you know that this stateid is owned by a different client
>> altogether,  and breaking its lease doesn't require a reference to the
>> stateid.
>=20
> You're right, the intention was to make sure the delegation does not go
> away when the recall is being sent. However, this was already done in
> nfsd_break_one_deleg where the sc_count is incremented. Incrementing the
> sc_count refcount would be needed here if we do the CB_GETATTR. I'll remo=
ve
> this in next version.
>=20
> But should we drop the this patch altogether? since there is no value in
> recall the write delegation when there is an GETATTR from another client
> as I mentioned in the previous email.

a. Neither Solaris nor OnTAP do a CB_RECALL or a CB_GETATTR in this case

b. RFC 8881 Section 18.7.4 states that a server MUST NOT proceed with a
   GETATTR response unless it has done one of those callbacks

So we have two examples of non-compliant server implementations that
don't seem to have consequences for not following that MUST.

It doesn't seem unreasonable to recall in this scenario, but it's
unknown what kind of performance impact that will have.

Can you send an updated version of this patch, rebased on nfsd-next
(which now has the other two applied), plus a patch to add a counter
for this type of conflict?


--
Chuck Lever


