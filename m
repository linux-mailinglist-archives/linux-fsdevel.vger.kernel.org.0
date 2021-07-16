Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFD3CBD91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhGPUQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 16:16:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62158 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233644AbhGPUQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:16:08 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GK9Im7010862;
        Fri, 16 Jul 2021 13:13:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kNTBruFZ5RZSrKI6VZhDFed99XFTUqJvnV5IbHUm84U=;
 b=BC0dp04lxBsOZLwBCU5tpsWeqFttBcdxgMApa4yA4CjZMuNC/Q9fmUMpK7O8CKOWh705
 750rZjSiLKmvTO/qYOFRu2JhQNhEpUAN1E0m3b4n8btfexjqNtuHt7lpCuITCcHJjKRC
 GNsaflOzK740gUFPJDD03YVbFP/G7DiowhA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39tw3b68hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Jul 2021 13:13:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 13:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu39YXMLHD9MB/9leopQatmrIzBv7t5ePqmuDxgV140Hr8ro0rx6ciKr2uXqn6yk1DL2goTpnslJYY5yGBomCVML4XcvMNcejePHyr6OkAeH3ddbbz5kgZZYAq2pJJkphR03O02qJFmJw6elVy76Be90uua+6xhi/r4pauchQEnjwMpRkQdAZbKHfQYOV0cbHlScu1XCKnX/sLY1hPY7PK3mKfl7ft4+vxJONjeimCYEtgMzfKQ4pprPEIV8UuPStFKYXkuP+quJVhADh5QB3R4RqvfpW6xmamcAuVnzy5J3JSjQ7lGrzjE9z+Mjywj5YkHIa5TVdMSx0sfbyU7ekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNTBruFZ5RZSrKI6VZhDFed99XFTUqJvnV5IbHUm84U=;
 b=RGyBSHIcJNaNEXAxQ8XlXh91l26ZihlThZlQT/p+NIrcmlZSBGUajma/jP88GUkjNHcJ9I4tRQHoDkpjHpjLUaLZJ0X9d4lGsMs45YW2fgnD3mfpWOod+FGEguvbbbaam97yXRzjGB1FJ5eIAlX8FtuWhnOwQa8mCI6/f9VO3Htv+Lr3wXfIjPgO8ZFMgJHRCW/G++1ciXZM8+lURkVLM8eXHj8y0VCr5mcUelvhmlWICg91Bzv+Cwv9hDOD0ewUFtESBYI1rpvUc3zAyLDaemSEKyMhwlbBbgM5+Y0t8bBoGKY8yD5lXzlC6FkApK4brk0f6yGScMNnrkgTVei3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4868.namprd15.prod.outlook.com (2603:10b6:a03:3c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 20:13:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 20:13:07 +0000
Date:   Fri, 16 Jul 2021 13:13:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
CC:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
 <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3533) by SJ0PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:33f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.13 via Frontend Transport; Fri, 16 Jul 2021 20:13:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25922e44-79b9-497e-471d-08d948962060
X-MS-TrafficTypeDiagnostic: BY3PR15MB4868:
X-Microsoft-Antispam-PRVS: <BY3PR15MB48685A4577BC4054538856FCBE119@BY3PR15MB4868.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2wgkPMW+LGG8iy4g4Lz1HsPLUp4dN3Asi/B2LlB+FcwHRoE0GppiG8CfcxTPpOUn/ktxBzFzkp/CfadViAeINMHgj02gBIib51PRb9B/hODCelHsv2Vg8uCs8X9WdPgdSRHlWlLAN9UcgSEhg/K4T2fq/lF40X7Y7Cms517YRWo4cBAMJBIjmf5fkI2SEJXOyed7Mk45OP7XYBs/Htd0Dmwr5e6gg8loPPJvZ8d09uAd0WWz3yxZ7xicYYJQMo3O7POU4oYQJDfJgOp+qGyuBalbowXplDJ4DCXcuoFweP+KwMC4RFnbm9SeRBlIbWDS0uVRIJ5bwhpQ9bR4h5ZWmIhKYHw4JoI1a0dvl+iAIAfNXtFTFFktcXWqC3MnkSLP6bhklT9ODJu0nPHKqRiTZLHzLv4r9KM8IhWcCndIjT73JBbJCtrz8OZEZRlLSG0qRwB6jT5DshCjiFysQPdCJTbhZh0dFRqjKM/LQVepdaGJN7iiLM8q8gnIxcm5QaelcROPY/quvWtjGqTyCVL+GfisUMk5cSyK8OawmxnoiPEa8gQlyhFzDYr2hxLgQpL363c/I78KGUiRDkChXj0OmqJGGz6vPAJVo2IIYUs3xMdC3OeQRQHkhekSn6rGwd5CqCqEma6x5c6sTaluY7OmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(4326008)(55016002)(186003)(4744005)(2906002)(5660300002)(9686003)(54906003)(8936002)(6916009)(8676002)(7696005)(6506007)(316002)(66476007)(66556008)(52116002)(86362001)(66946007)(38100700002)(478600001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZJlmxeiOm+Hl7vWKyn/3kSY9disMU1/XT7x7LZiIjCSTxxVfgkGAiq/8ZvH?=
 =?us-ascii?Q?i1X/SFCJ3Gtyt5l9LXDwdqJJDPyimH4pNt+17Ey0SZ3z0JUqQAxN53tcb2Au?=
 =?us-ascii?Q?hQbafSR9/cn6MJPi0DxjbhorPlh0/l41LS9qjCxWGb3NZIMOvXmj4aJukKQH?=
 =?us-ascii?Q?90aG7Dzw6nEHNzkoI59lOWcXxoAlERynji5OrysXoqbMCHO/DV6vwGJfL51v?=
 =?us-ascii?Q?OnzBaCh4R3Qq+f0Bg+5az9SH5UFozgySedM7nr/3EoO3Qtm14GnVPFomaPbg?=
 =?us-ascii?Q?4YJS0S52t0Jn5fIv5tzBOFL8kkRyRXEnKmxhc6isbPNvt2ujO05SJZzGOfNk?=
 =?us-ascii?Q?2mt4Gw2VokLLnC9ZoFx8uLfMGtu4E0MQaruXyY+JjVh9cA6bpy11GhF7GUsH?=
 =?us-ascii?Q?P+G94cBPJd3wDTIPWxtGPQ3QnSiHEXNX3g4CLPkWB4pPlntGQQHYZPmyIsdB?=
 =?us-ascii?Q?6U6j2XMK7pnj8+TsN7Ly1a3mm7tjSDDxFUNRE93B4VHG3xxrEi93fCksIL4k?=
 =?us-ascii?Q?4qjS4KHMKFL0iPWSQvfJdxNHoBNYZnQ9Fis8ogozlr6kSTZgjdjsYdr556w7?=
 =?us-ascii?Q?eda1CnMIjkueGhnP9+04X433tQDB6KulPf+v33TBsbBEfU45JsRRCvR01xKD?=
 =?us-ascii?Q?Gk72DSBOOT2RRc15eVFSCN0ydb3mdiy10Is8F+W4GD+EP+nZDgKT7GiC6XoO?=
 =?us-ascii?Q?fWX80sv4Sw3LJMHWOPQlJFO3772bHz1CDq84SzfarygUwx3geJYL0w6wRhiq?=
 =?us-ascii?Q?gmECEuq7LsdcbELCdhHZ9uENPkdGm2i2nCxpb0xLwAm+ctyScA/OdDLedwoM?=
 =?us-ascii?Q?VuaFore65f+T3mp8mpIVH49JisJn7y/AqtL+jb2v169TlQDWLPITCVq/Wzc0?=
 =?us-ascii?Q?9fUJPen+u6YIWcmI0DOeFzU0E8KbujqPuHKGanx3sXJH6aT6MpI5MGfB7Wrr?=
 =?us-ascii?Q?pTy2bmpVoEs1ixj9TFvZZXncGRAsSUHMTCCdC9xtxhcAm7ZPmJoUQJ94a3xU?=
 =?us-ascii?Q?8vds4l/kifUCTc09LSnsWiJKs2wIyLVKqVCIHJCfh4OXtIGl30H2xtS55W+Z?=
 =?us-ascii?Q?SOVOzcnWA55CuGqH7qVkEnEOGOLRtrNfIZyMykSVbRcNreakXMLY7U5Cmavu?=
 =?us-ascii?Q?n5XAo6BkAu6tfISJjygo7niFFMWkUBDu9r7xSXLQiFdvx5Jp0RPl4B5w5VT+?=
 =?us-ascii?Q?kAtXSauxpp9QTd9z53ZurtTvov4U9yYEki3QGFFgBM0L0xJd6vTErvoLbBg1?=
 =?us-ascii?Q?HPe+8RNVIynvRzlu0AIK65oaSuuxFrXtzZsGm6uh+zHNK2O4CvNqFuNuCytI?=
 =?us-ascii?Q?Lv6yHgNxQIhe586nsPaFM85iel5670AWcEChrr7msrz4IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25922e44-79b9-497e-471d-08d948962060
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 20:13:07.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yA9ijKqcbj8PCUE0OwWQYiN3ifuRlUHpiuTgUi+hxxxetssl88qM6+NSgwto44s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4868
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ME1FrIHQEnVdPAygiuHlJGNDrpE5FcHO
X-Proofpoint-GUID: ME1FrIHQEnVdPAygiuHlJGNDrpE5FcHO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_09:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=862
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 01:57:55PM +0800, Murphy Zhou wrote:
> Hi,
> 
> On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > > Hi,
> > >
> > > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > > mount option:  -o dax=always
> > > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > > can hit this panic now.
> > >
> > > #It's not reproducible on ext4.
> > > #It's not reproducible without dax=always.
> >
> > Hi Murphy!
> >
> > Thank you for the report!
> >
> > Can you, please, check if the following patch fixes the problem?
> 
> No. Still the same panic.

Hm, can you, please, double check this? It seems that the patch fixes the
problem for others (of course, it can be a different problem).
CCed you on the proper patch, just sent to the list.

Otherwise, can you, please, say on which line of code the panic happens?
(using addr2line utility, for example)

Thank you!
