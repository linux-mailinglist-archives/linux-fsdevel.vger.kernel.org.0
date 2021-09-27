Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF354194BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhI0NFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 09:05:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56286 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234398AbhI0NFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:05:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RC82DZ015432;
        Mon, 27 Sep 2021 13:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2NMcWJZPstyjndwvvl7mB14+AMxNQuXEPGD/tFwn7cU=;
 b=AxE4MQvhUZ8XdzowlnyosdJPXuubipjVfE/KLQS52UGact5e52ylVc38hJZsVjzwTahS
 jD/btz+gKYWs9kcGCsAXHhgb/T3XWEDzs1tvos3Sph1iyHj5iJSAwj28uidq92Gr5Z1K
 UcT5q7O3MRKmon3dA20UtAxdFsa4L30H8zbKcE8i/ebP60Eh4JlLhbdWj4QaXgkRZTlp
 1PiN/bShLO/vlHaz3B3QnHmI9LUyU/xAFzYisaJpm6zqxTllKdbzx04f3IHldYkZ2zzI
 xtBgDO2ySL0RB1FUoaKEWmgL5KwfNO7KgM5vCQEFduxyl7xiLwFQV8aTnVzWKusWlINQ jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bar0nc6hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 13:03:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RD0JY5063756;
        Mon, 27 Sep 2021 13:03:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3badhqxrvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 13:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2pYaPUOQrxac1J/6FYFtltZvjTPdDNx2M3+O0XeTdCZyTDVszJZyQPJ190HDZuFXxYR3NTZ6fcms55U9zwDGuCZQXSmXUCXcuDxKkG+xekS9W6bsEjrYBP22LIPpJIMOK+ezqpVfsduGzD8HFyCz8d+Pk32Wm85133Md5Q+7Gn2fV9YAJmRQL8DC135gFUJ0autounM5q7DSPj6wMnqfWgEBBQtHPJRq9LiUYzzibC0dby4+qeGEbPSIuUH77S5jw1eLgel7e7ncCf4viGrnUs8DhJL9RQXovaEjd4TgCgui2DdQfGN7JytPfdvh3uk0A197dQmipQy9lqmWR8e4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2NMcWJZPstyjndwvvl7mB14+AMxNQuXEPGD/tFwn7cU=;
 b=BAKg05BaZ5VPkWlx7CdUrzSaxwvNALEhUDPP4kl+1nno/P4SQOS/hMVL5zKO568f7Q6rgEbl9SyDz8uL1+idaGQ9jocNoaWbEy9fwvmu3I/g2ljSNU9mvVVM1y6V9naOUq3B66i9KGVy1LHyhjNH8va7AZsFSdVdyhy0PysCIe0snjQb5d+MABLU2gT/7QUecyvu5cUkKjexNJaVT5ADVD7sMuYVgoTIvOT2zR/+GClJe1+uGdfwuTWglCJPAAHe1ws24fK5sPIS9a3DVxczKL4HpM1VvjZEnvPJ8PMIMc4vT7Wk+wjp3V9X/JFpQo60DzEkpDFpJT18hYqHp2SDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NMcWJZPstyjndwvvl7mB14+AMxNQuXEPGD/tFwn7cU=;
 b=Y/jvKDkkt1EVzVwJ7PZ//WxNoSylXUloFw6K+aBYRCQAiPdDyEelfjmjl3BpboQvCbd2kbTVBdxENmsYbpZkk0GGYegXC+7TeSawPqtukXEP5QX85epU3vi3MaG7SX9GeZ4vNmsCMCbtd3tLm3Dvq8sA504VVL65yA2edFO+04M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1246.namprd10.prod.outlook.com
 (2603:10b6:301:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 13:03:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 13:03:17 +0000
Date:   Mon, 27 Sep 2021 16:02:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] vboxsf: fix old signature detection
Message-ID: <20210927130253.GH2083@kadam>
References: <20210927094123.576521-1-arnd@kernel.org>
 <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 13:03:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 957f6063-5805-47d9-ec27-08d981b72c93
X-MS-TrafficTypeDiagnostic: MWHPR10MB1246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB12463C2BF79ABFA2FF84ECC38EA79@MWHPR10MB1246.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X6eW1F5nbQWOORzRJUKgqU8CS+EMyQOEJREzRnn5dqs+15wOMAemeRGsRhAnMCYNL9ZG96Nf3q5pWLcmlv4KNmkMQtq/AC7PslWTJ4X1nmjbehvEty8897DiJH5o6lWyilsVDao52h0ecw3JvJOzQ6tOM3XFWHGnPcy9Pk0oDzYtPIHqjyNdxe9KCZ18zHzcsGyTF1wH6AuoYV3HZSXF0D3ymb0dVvee0YGA/zdIqVdBXIG3BhpiU4agJ2qtJ0Lw8j4OeEcLgU++StjB2BlC02g5TrBdNKYgT9GTasMhV9GAD1xqG9JE4xDT6cu9C38MSJ3pWhN1wKo11pJu/uaFxbeaMcpLiBlfBaCYT45UAtTIaXDiXRMN9kQESJgI3fojxGC3eehkgqUaUT2IrYJVf9l+U0PIRuIdA20T+2CxL/sfvE7Z/iUgn7reHC3IXrUcBnf9UFYY0Ven2Wpja/0Bsf8QbHEnFuBD7gWi6vkWcd0ePiBwh+KXNjz/1DPjAAu909Ar6pduWykFUhw0pZRUOYX74YxekVKFumcgWa29Ufm9X2MvBcVKl0m24e0zQZBKXtehZGhO5x7nmJ+CnC+4IfzBVeHz1HJ0HdvxHj5QaJklMdGe0lMrEeHFhCkbuF6OMe5pCEPS+X3r+rXKD95S97kxL2DHwcXpJxRy3bOOV5lO9Dw1Vzh1R5ex9W5zZUVa2TCzPPEyThno/gpU5cBoqk4MiovdKxgFpbHm43FF0ojpcOQ7uDPm5wNUPPiVIou1jTllMsT2dAxhiRN74b36Ims0hrBhVADn++QohqDUYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(52116002)(6496006)(1076003)(8676002)(186003)(5660300002)(26005)(33716001)(33656002)(6666004)(9576002)(508600001)(83380400001)(8936002)(316002)(44832011)(55016002)(110136005)(86362001)(53546011)(66556008)(66946007)(4326008)(956004)(66476007)(7416002)(2906002)(54906003)(966005)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0e04gkMfq4O+rNmMUeANG3av2BxCvCjCoJXXhQPTe/6zRidvvHmzNernLfN?=
 =?us-ascii?Q?EUpC4z1o9P+IQEZb7ZIQSNG1eQXLOZ32WhCRq9pPK0bhwwuNTjDVDSRXfdYv?=
 =?us-ascii?Q?tpyu7Wlx4ySQNqUt6hkguToRUP1eOKYFqlIiretTsU1clEIcowKCG2ycYNPo?=
 =?us-ascii?Q?vq67gnbzzYTT/1nLOjqIYwCO7EA421FlSA9Jkua7/3nxaYRhZqPGroOTVsTT?=
 =?us-ascii?Q?c3djZV/yPH1Y7DVLNZDhHpi4DEpTpW2urHaKQCjIcwCtXkrFdcgxe6OfwTOi?=
 =?us-ascii?Q?/BViatfkozIVPtvJDxkZA8nP2/IFs4APR/tNzdUtWbY3yLAFS7onUaPZmuW7?=
 =?us-ascii?Q?xhwGj8gWtWuDGf9dzzrZADHR4Lr7l8okvsOWEXb0b8m33XOKyu3+/4OrkOJ0?=
 =?us-ascii?Q?crhuYD+aoM0P98a9vDt/pVlCeYnxqSR1F9iRFrU0bdgxvQs5i64m1HYQnw53?=
 =?us-ascii?Q?DuYK2z7UJYcOtkDuyKwca5JjrPmvo/JlO1FU6jpR5s03QkOjrRS9GEtFoPyw?=
 =?us-ascii?Q?J0dlS1b+j7oK1QfDHbDhFyfBZ6AEH4cc8wki7gsfyEKUYCbi9YBOGBDEZtJG?=
 =?us-ascii?Q?ULKWlsySQGAWWwWrWV+0pBLu6W8i+rPvgpyZDu2wh6XGQwNXTsZa9Yx1zioB?=
 =?us-ascii?Q?07MyL5Hps6l7Al47s7zu5x3FPNhhlqLmMlXymqII7Y0VgFWrkasWKs+o8OA1?=
 =?us-ascii?Q?vq1b/Zl54ufXBBQEh4yM+a0LBpYi23Rm/iaGvNOfZc4+1ulJ9v0Qlzp4tvzF?=
 =?us-ascii?Q?9tvxzJZ4uU/B+8+1PUu58KGUsCBQ1KJPh4oLFLEIaz2PWJ64YlYr6sj3JEJ5?=
 =?us-ascii?Q?phSDyvLX+LLWtxt71FJM2sQsH2qK/XrPubxZ+9d52IPEdNqj5fKgq1yCdP26?=
 =?us-ascii?Q?S6lnxcUBhu8Iutw1yDLAXy+4Vq3qWOJdN06c62anpI/6LrxHplWkC/2TlHIZ?=
 =?us-ascii?Q?iz4Sneb9ri7gV6YI1VvxU0//zojH5VfeEo3SU5DoVuEyuza95GwNv4o9txRn?=
 =?us-ascii?Q?Yk1fvMK2kbMnsfO72528M13HiFnVT15pu8svunTT4uQj3oRRgOrWsvGtshVQ?=
 =?us-ascii?Q?+IRT0iaPXdQHN4sv5FD84Ua6UbpmHVA2RFM+ZMfMbhRNUMvkiDZzfIHPALSF?=
 =?us-ascii?Q?cukIlK3dVTeCL1FVVBl1MGChAbTfrPeekbcga3iPxZGlP3Np7cx4wXtq4WB0?=
 =?us-ascii?Q?L3EmfuUOTHbKoEa2xE5OeYZRR8MzJBAIlTqty2qyVimygTGFBf44UA17xf4h?=
 =?us-ascii?Q?vjz9StPEA2kHU532NlbgeC9d2DvbaqNu+m4LqElzht7f1A+VSmRagNwiBm3R?=
 =?us-ascii?Q?x1x728HJ+EMDpy36xOQvQ6PU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957f6063-5805-47d9-ec27-08d981b72c93
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 13:03:17.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6KLcDBY6V0YuXklpY0fAwNWoqa/er8MxPsgBSM7kAwQ/J74HnV0NDOnEv1B6h1Y49ECz1lIxaAYJUk5L6QA3ShGXOhlSu1ycDlW3BRmZGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1246
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10119 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270090
X-Proofpoint-ORIG-GUID: toiYraUUfyGe8NP3ymQyLMsN6nwYjHXR
X-Proofpoint-GUID: toiYraUUfyGe8NP3ymQyLMsN6nwYjHXR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

GCC handles it the same way as Clang.  '\377' is -1 but in Sparse it's
255.  I've added the Sparse mailing list to the CC.

regards,
dan carpenter

On Mon, Sep 27, 2021 at 12:09:01PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/27/21 11:40 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The constant-out-of-range check in clang found an actual bug in
> > vboxsf, which leads to the detection of old mount signatures always
> > failing:
> > 
> > fs/vboxsf/super.c:394:21: error: result of comparison of constant -3 with expression of type 'unsigned char' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
> >                        options[3] == VBSF_MOUNT_SIGNATURE_BYTE_3) {
> >                        ~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This actually seems to be a clang bug though, or at least a weird
> interpretation (and different from gcc) of the C spec.
> 
> VBSF_MOUNT_SIGNATURE_BYTE_3 is defined as:
> 
> #define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
> 
> The C-spec:
> 
> http://port70.net/~nsz/c/c11/n1570.html#6.4.4.4p5 
> 
> Says the following:
> 
> "The octal digits that follow the backslash in an octal escape sequence are taken to be part of the construction of a single character for an integer character constant or of a single wide character for a wide character constant. The numerical value of the octal integer so formed specifies the value of the desired character or wide character."
> 
> Character constants have a type of int, so 0375
> clearly fits in the range of that.
> 
> I guess the problem is that gcc sees this as
> 
> const int VBSF_MOUNT_SIGNATURE_BYTE_3 = 0375;
> 
> Where as clang sees this as:
> 
> const int VBSF_MOUNT_SIGNATURE_BYTE_3 = (char)0375;
> 
> Which is a nice subtle incompatibility between the 2 :|
> 
> 
> With that said, the patch is fine and I have no objections
> against it:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Although maybe it is better to actually remove any
> ambiguity and just replace the defines with:
> 
> static const u8 VBSF_MOUNT_SIGNATURE_BYTE_0 = 0000;
> static const u8 VBSF_MOUNT_SIGNATURE_BYTE_1 = 0377;
> static const u8 VBSF_MOUNT_SIGNATURE_BYTE_2 = 0376;
> static const u8 VBSF_MOUNT_SIGNATURE_BYTE_3 = 0375;
> 
> ?
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > fs/vboxsf/super.c:393:21: error: result of comparison of constant -2 with expression of type 'unsigned char' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
> >                        options[2] == VBSF_MOUNT_SIGNATURE_BYTE_2 &&
> >                        ~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > fs/vboxsf/super.c:392:21: error: result of comparison of constant -1 with expression of type 'unsigned char' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
> >                        options[1] == VBSF_MOUNT_SIGNATURE_BYTE_1 &&
> >                        ~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The problem is that the pointer is of type 'unsigned char' but the
> > constant is a 'char'. My first idea was to change the type of the
> > pointer to 'char *', but I noticed that this was the original code
> > and it got changed after 'smatch' complained about this.
> > 
> > I don't know if there is a bug in smatch here, but it sounds to me
> > that clang's warning is correct. Forcing the constants to an unsigned
> > type should make the code behave consistently and avoid the warning
> > on both.
> > 
> > Fixes: 9d682ea6bcc7 ("vboxsf: Fix the check for the old binary mount-arguments struct")
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  fs/vboxsf/super.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> > index 4f5e59f06284..84e2236021de 100644
> > --- a/fs/vboxsf/super.c
> > +++ b/fs/vboxsf/super.c
> > @@ -21,10 +21,10 @@
> >  
> >  #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
> >  
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_0 (u8)('\000')
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_1 (u8)('\377')
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_2 (u8)('\376')
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_3 (u8)('\375')
> >  
> >  static int follow_symlinks;
> >  module_param(follow_symlinks, int, 0444);
> > 
