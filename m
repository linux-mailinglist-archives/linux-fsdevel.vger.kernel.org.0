Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B945A1FEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 06:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiHZEhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 00:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiHZEhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:37:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C9CD7B3;
        Thu, 25 Aug 2022 21:37:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4671e025354;
        Fri, 26 Aug 2022 04:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=C/nDiUz9OP5PbqKV0oOUgtO7xIQGX8DWEEEDpBV/It4=;
 b=uKbRpm2BKpVYqt00No+y/p4A+tGooyMg8L5qOgOhefiG+97sJR1xQzxH1BgrUHjO/Ngg
 M4+W4Ih19wCkjtFKzkrJm026m1KJYfSQwd8Wn7cxDRUpr+M/lWpKaFSxsj/H+a1O5lOa
 e5tpL6zs9avNoQBwv/v1e1zhyhSw/z7PkBMh1LL6lzhtRqfxnOjt4fb56zVFEvu42Lzt
 mRQFq/Vt6UFxzXogH83dAFlhVWd8kQmNxrIySaIPY0ZF0fggErJ4kE6Qo+bagaoUP8EV
 vv+DBlNe42yyfVX6kxRNodZV43i7DsRMdkF/5nK4iynsY0Hemt8QIDmuU6LDK04GKn/v 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w240jbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 04:37:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q2ltxn009542;
        Fri, 26 Aug 2022 04:37:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6ntt7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 04:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/+Xnrmn67pUV4QvpoowLuJhYoBS+hjLMYypl49Nv2b5nrBqZB+vQMSL9dDDERcmY+LZ4VQEI9/zxixl5DgQq966qup9j7sjm1ahr17vwj3W9YOpFX+ez7PisfSL8QfgOZBIZJmqCUTdGhP6dT3YXCf5y/p/sBi9PEE+q4XsGItlZXProYMHw15WhfonekrIIoxhFgIB3QYxMbjDTRU3uFXoWi/rI6RXKPq4CEyDnLPFxITOrajPB7uC7olLTNcfup5Rk4rbRpkN/rkME5gn4nfeg4GmeKZ6tJmFtIJalsJ2BhFeeM7rFxbUbQmBQ9VZR7QWu4Fml7kBgLsuw5hV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/nDiUz9OP5PbqKV0oOUgtO7xIQGX8DWEEEDpBV/It4=;
 b=BD1rZwZbp0p0OfLSpgvXsDMDUpsMxq5hrjxR2UOaDmeaDSP1BmyRDxYDn98inqCRxVyrnNBCUkL4FK3fxSRzvouga+qWTVdezzpGiZb6pzbkEG8k+FCeJ6lW+u1pdDJtSz8Cg7LzahpXxpmK8/8SUVCLGjguY9fn3o3AXMgZ83dEZAoc1JKtAF2rUoCQ2lugsbXyUNDRDDfE9C3C39SD5pPz8QjEAMko1MQJ+IIRUVBu4OhTnIXaslL9XspV4m3pQ94r2e9GAPHM/ARGg3hYWvjNao5GwJF6M7U9xgVwh58mic/H/cOuoVbKK0jWXxcd6WOelXo0KQqBGG/MSkO/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/nDiUz9OP5PbqKV0oOUgtO7xIQGX8DWEEEDpBV/It4=;
 b=zSiS4jhPMwyBAQPnpi7JkK0KPYyTdvclD5cSBOv4cAepJAYTu2H1KKVMcm59Dl0XBzte7ZWuZpTh15FTE8VvmiTx28uBF+7/YJbHxWSwq5NO+q2JA+VR2rXYkT4rI6thPmQuPcLnN06qFoNzbXjPQu54EC9nDRAmDjuqfMsyvxc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2152.namprd10.prod.outlook.com
 (2603:10b6:910:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 04:37:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.025; Fri, 26 Aug 2022
 04:37:18 +0000
Date:   Fri, 26 Aug 2022 07:37:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com
Subject: Re: [PATCH v4] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Message-ID: <20220826043706.GC2071@kadam>
References: <20220826023515.3437469-1-sunke32@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826023515.3437469-1-sunke32@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0038.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::26) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e208203-7c90-4f08-4e48-08da871ca8a7
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2152:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2Gxz1Edep06EFKAp7hoergTii62rZ0zn5MWQhJQID3bUBppc59q+GHB87LFlKuANrLPkYnHgbqOvgy0vCv6EoEnruINuyNWR6SdOnVku4nXmJD3FZsbnbNjbkpLD/SQaU7iTpZUOfFEvAQxHUmRnC7b5Nof6HUZa7PdVbhu1rBB+Ndwy3hbLSgB2X8K9qaz3UmqSDuPLectKhxr/o63p76eMsq8biaiXLuyIAHFJKGmCsx60vlHa+XJmr1m1jbhtgm8Kid0UkyS8RYJSJ8wI1nb8XClh4/+guHRPW9FSpPobdIkrSmHzcsPzrckZpArYbdN/sibmPXe+PD7ob1/w22urwurOSKDJVoFZAJXF6bzb3wuSBIFxWwmtyKsSKdMgt2k/Bqbtsm7UyozHRM/azQVmj+//C5FImvPllAXkOLCflXSOFEBxovxMBf7MqfdjOtxwkCVj7Ls8xLey0HughCoDmNPuAa/43322LrPiynCKLPVDk8fU+HdMH5mkUN5Az/FSlQeMW/8XEQno3GJalEZHzpwIo7SR+Gk+Xtg1ornBgDndKEa5YpX9NpF/1Dk6R7UX6mIf3i29SWrHWnGejuhTxVy8AH1+7kMPUUimUGBLzI6+dJ5KctFyErQLCZlhDDe6vOqhXZ2Hhqs9aNSWacEhTRGl8tD66tDEe0+clgaOyoDdULsCGwuFHFbAx60y2wGLR/4l34glyack0sIMUBS8bvU1bYJgdWdZ8eMSXPozmPXYBYcgcy6CBbIMPCbWI9Y2/6d0KEchSksi4rVig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(83380400001)(33716001)(38100700002)(66556008)(38350700002)(66476007)(66946007)(8676002)(4326008)(5660300002)(9686003)(4744005)(44832011)(26005)(8936002)(6486002)(33656002)(316002)(6666004)(478600001)(6916009)(41300700001)(6512007)(186003)(6506007)(1076003)(86362001)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMdJJOFV79TCNgqP3TOgYODfv9pgvnx2soFuGQ8bsPV6w2TeL1QVkmtmtN2I?=
 =?us-ascii?Q?eih8AM/gcUt+bsbi3WiTM1SGS+zM5bhudLSW/zFP2e7/YDzFGv0Nz2xhBXM2?=
 =?us-ascii?Q?LFI6R3lvWUN30rivVe159C553OlnyuHrbqUuSHNEHQxdKMN9w/jfmwVAiUXt?=
 =?us-ascii?Q?rs7owahbLICrvsx2sM6HeVPyuZg/Zo8sFHpxR5KjGj01PL5GftgL43nwBCe9?=
 =?us-ascii?Q?ufmJjPrEh4AmkUhm4GvIWVEE/GY14yKfHIEZkxhfu3142Y7HKxKjghBfDhgW?=
 =?us-ascii?Q?BmTFYagwgWJjHqIVVSVXC3awswBMjVcnk2PH9+hOoWzCFYlwFLk984J9Jk6O?=
 =?us-ascii?Q?LM9oG44aL85CV9SbgJIoP5KKnUOKJyi23KBLvs7wF2h6JrvPi4N9TICAMSeI?=
 =?us-ascii?Q?sOn1zOx048H4FuEOER9XBx0w39/xNmMiayQPBD1hqvcxxPWCOkExlQOUrg/b?=
 =?us-ascii?Q?WLjcsf8ajrm3zpiuEt4IJ48Su7nozKAsql3PZW8gp+sNBBlzuZx1MD779Lwf?=
 =?us-ascii?Q?bgxSsLMWUjhX3JqXFdBobJYjCildPhKPDJvCJ877giR9pLOcJ+kJHAXBRBjb?=
 =?us-ascii?Q?zPunEQL11L/i5yJnl0n3A1ewCViBeNfTbC20NKifMJkZhduKnSSdIuG3W97p?=
 =?us-ascii?Q?HBsBfES9BeUZucFUpNYEWCycMhQBhoVfOdDYw1h3EosdLOtaKkZWvpzmq1Vu?=
 =?us-ascii?Q?0CqLo3POTbwXCvxE71XrXHCkOHJSPS6OnTxXGHYwC1ZitzX9lQ578LcdJ7J5?=
 =?us-ascii?Q?BlTF+NMMjwp9XPeGfhfqgKUWWnG0yiLPhZOLe+K2SLlpZQu/h9oDVdel70aw?=
 =?us-ascii?Q?kTrSnZtDwSmYpbPy1RzQfBLsK0b26KkyBmTGvbyT7tO19XcDpFuUqk9PoHwU?=
 =?us-ascii?Q?6+IHZsJGZ72rMEEcOyg+/EMVdpcMUzPkPSwrIc8IvPEaYbubiRwOxfQgeAkD?=
 =?us-ascii?Q?dVmS2hgI3PwF7TqSoxQLelF7N6VV55W3M2b2Fg1mxldwzFaIFQHcSgEBgkOB?=
 =?us-ascii?Q?c2fxXc8uVSxnYKm93tSTvStozpRCN+hKaZo5GkBeOvH8fsAu/hDUddR6Uf6p?=
 =?us-ascii?Q?I81qvYL2YMyuA788uJKpf8zLNou4GZHxOo6CTXbfW8OdpaBwbkJXGbsiWXOd?=
 =?us-ascii?Q?8jzx4F3cVP/OoNNSeuufs+kzPcLeUwWy4f5gYV79zpqELbOg1U5NFhD45KX/?=
 =?us-ascii?Q?5mk147QpHrgz2yO4MpefZGv+bEkhlFjXIGuJwE/3SarMCDpVLO1fczQNKYMV?=
 =?us-ascii?Q?cbcFSt/84N7zTOz8OuwvS0+Yqroud2/QP7up5lDCeIe8R5w5Mb1AouGQgd9b?=
 =?us-ascii?Q?mfFRqMcjdCwUK4ee4uTdvs+dQDysVGrPgsIaXhV5o+R/kCLGjbIXEQPv8jDx?=
 =?us-ascii?Q?WJNNwBzEOaguNL4MbdtSvd6nVE3Arm1WX843Qua4pA7U1ddCofQdiqV0jJf1?=
 =?us-ascii?Q?63NSEwpFNKHUVMRAXWdILjlE2QNI9iE1BI/8cnMi7DGZja882b5DO+knZYgQ?=
 =?us-ascii?Q?ZZkZHAWgbjGb82ap3gdgmqnhYWyFKCfzZmhFgi+SxYhgjzXgEGU3evWsCLb+?=
 =?us-ascii?Q?oeOikKGaEWMPtmXfZutSp+FFVx9WCdMCxqKhQdqdZTG7k4f8hmfmefNzedX7?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e208203-7c90-4f08-4e48-08da871ca8a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 04:37:18.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITkTYXR7K+7JumsdOL8ilC6WFX17eeSC/PrMKGsTlAYDp7Pj8fAtQc9TdrtnMvEDgWt6Q7EljMVKOkn57IrB5roLURPhWfRbe5lYpWAgP6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260016
X-Proofpoint-ORIG-GUID: oVsFl1BzbbFnzQ4VOottSCBbyrtiP6Lv
X-Proofpoint-GUID: oVsFl1BzbbFnzQ4VOottSCBbyrtiP6Lv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 10:35:15AM +0800, Sun Ke wrote:
> The cache_size field of copen is specified by the user daemon.
> If cache_size < 0, then the OPEN request is expected to fail,
> while copen itself shall succeed. However, returning 0 is indeed
> unexpected when cache_size is an invalid error code.
> 
> Fix this by returning error when cache_size is an invalid error code.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> Suggested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v4: update the code suggested by Dan
> v3: update the commit log suggested by Jingbo.

Thanks!

regards,
dan carpenter

