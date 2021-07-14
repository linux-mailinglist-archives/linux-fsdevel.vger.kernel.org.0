Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7C3C7D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 06:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhGNEPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 00:15:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229451AbhGNEPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:15:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16E42WhJ020051;
        Tue, 13 Jul 2021 21:12:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0EmlJ1u2I4mM2WXwo8t0eqhWMHTc0ttkikh5FhWRYhI=;
 b=jtm5Lmxch8KytRNJdj2yGvb3nvHkT8pOT0wJFLTP9BEYuw63ouj8OYk2pQJILvrAX586
 Sp2FB93ldyXKmmY1hof/bZaN5lnidwZVlW2GrS6LdcMPuTnENT8Dp9vgUy11RLysx9ZW
 EyNcKTdt+lO1hVfmX4B1JtudZOIsUqlMifM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 39rt40tfpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Jul 2021 21:12:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 21:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRPbewnrIz8HROLwRb6CZZUtZXp+Punj3RsI1JSTLOIe1KHZkXeoljGgE4FTX7R+2xAkWoh86bBLThEdp/MrO8sEY634zd7NX9t9V8aPisd+Wx3HZY70XT5R1M+qWag9FXXKbusqffyOe3NiBRczZJ1ZcZ3VIyooVt/BBmTkDHzyb7D33FmmIDcEzc+Dts41Hrc4V8OPKMI9v1PPme0E4PRSI9ixTYzX50tjTEkU9CkQl/3cKTBc5IhAYsiP0O5X6acgbExLu+pLv9+VDoElOD9BaLzxxP1pRtiHJwKn2poodeNYCYisY1foz8Hd/7dTz9csukf3GuZ3qLYk9pniow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EmlJ1u2I4mM2WXwo8t0eqhWMHTc0ttkikh5FhWRYhI=;
 b=l4Lx4I5LK2w5kYau3Akex9ZhNOVpuVE2ak1myifCZaP6UtJQbWN/O7sysVTtQB7RWX+X+0FL6JHa8cQ33VUWyZCwzkEh2btnf1hepzvfdHnNmnkRsd5xRsUwdHFDY4MDNvRSPUP85QIKVfZDvciLeZlzjHTIV1pxJdCbzPkP1Vck+hpicfJSNyaJ/4A8UZNSccMgie1ZkM9AlieaUxQ55KQGPo7lA1HqJtA/dr/SI2CLiPhnpvE/9vRnXeOgO8d8nYbu9mgllHFHXRD2SLpTEScdwIsJOCuFfzAF73vQSqMJLg1ki7Lw+req7wqSob/xRwk+7NPTRO2tvUNXDN42PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3126.namprd15.prod.outlook.com (2603:10b6:a03:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 04:11:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 04:11:58 +0000
Date:   Tue, 13 Jul 2021 21:11:55 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Boyang Xue <bxue@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8618) by SJ0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:a03:39f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 04:11:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c40806e-b626-4677-6004-08d9467d8627
X-MS-TrafficTypeDiagnostic: BYAPR15MB3126:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31269FDCDD213FF5F49CEF32BE139@BYAPR15MB3126.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu38mMZxjbXcP5lQo3xNJkwVFySSMQF3AmP2Vs6rd4A0gnC0CVWV93j+pZ82IrtANf4Vorfjx2tjH/9Xwm3PU4yQehfeHM2g0fsWgyQ0hVplZeB+hDbZINaeodaKt4T0rVRIG/lsBKMg9Xxw5ZiJD1ElWQPUg8nxoopM1f9cUNDR3xHg0v/QOXZdTBWbB479/3z2q0brWhMWo1ao+vPHFMoNjoc0i4uQA+ZzokaJ3x67815iMyWskaJHVn6XMHHHHwaF9snFtfmIYq3mOD/hJErR8oh6j9B0UV1B/zOfe6fPncij05jne6JU9OEd9w1x/qaV3G+73qzvGSgRIuCZqiaFJBXLRui91wRYrR5GdJ0tqb1fJnmG0TxhKVjuQC/OKVdAiixVC3QZbzvaPl8j3xQ8CQXW5HrGECUnEwt2sfMqOA05bYFp1/Us8MmwC1tiAp+Pa3f1eDj4R8wvE5V6lUDk5ZHAOYskrdRHYxyCvlIci0N2O6XmAlabps7uCaz+oav9H8MnqgWl/WUFp5ObbxGUoiAkBm6gvy2pAjEcp61z1YnlILmV70GOAVxTF974nst5+qC0BX+HHwENwGvILAHUvxAYeB7kOUD3iXFQj39LMGwgIEafa/csKLoOf4kusqrpBjAQexRF60DLXB8vnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(478600001)(186003)(316002)(86362001)(83380400001)(9686003)(8936002)(7696005)(38100700002)(6666004)(52116002)(6506007)(2906002)(8676002)(4326008)(5660300002)(6916009)(55016002)(66946007)(66476007)(4744005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7oyukP+g0K0KWVwaHcGRKG8G64Gg91uALJut+scNC3FxHFt3rnLwWnP5OxTE?=
 =?us-ascii?Q?wAUFC8roJls9y9w50Ce3TF3rXjKtH8ThSnK3tbIB0313ZKXEkNwezmhUHVMY?=
 =?us-ascii?Q?bMm6CCbcBTGgKZpijeiZDxtt50DGdsQq10rXHhamDMpMM9aEwmaA68Xzqr8f?=
 =?us-ascii?Q?6Avb2QhUDDc4YJQ6rYLgnl0qWdVp0X9LaBTtpCNNcEY5uNA6Od1HlAs1Nszw?=
 =?us-ascii?Q?oupqY3/br63r91eqzQM1lQJa3r8qnGL7LzjjPgTH8h4oZRc0DDx0Z+uxrGXW?=
 =?us-ascii?Q?Vi8VRwzflBmjXX2Vmhmh8j92y4DyXDn86cERfjQcxBtEptzrAtrWlfohR3ku?=
 =?us-ascii?Q?1b5Y/gUWlWS2cKXgg4FlZArdQiWIpoPzFTv38+4sJmC5WveRlJNqfh9dc6f0?=
 =?us-ascii?Q?1Dc2lpq3goRNTYtZvFZ2UJEVtmy+hCMP31p1bKlg55QXh4w4c7gAcId5rqee?=
 =?us-ascii?Q?Hb5xxWr6OiAZUb72GRMRXW5631HT/iOZQajXXlwD7sll4LoRr4Tho6jUtvio?=
 =?us-ascii?Q?QBq1Tgz13K8+7ryBIJxsMEyo8G/nnCmUzOE6EDzOxiQf1G1WnoFzuyE/K3y+?=
 =?us-ascii?Q?EcJy+CIZDmqsCt9/Ag8Itm374GGNdbYfm+sm+aU9ntawSRxl/ZvjjBtIo+BV?=
 =?us-ascii?Q?ptE4i3cmj7voby/0UexSLxBVv5ZCUtlzXDGpBnKxYoIRIz626TIQEPZZ0KpH?=
 =?us-ascii?Q?fpMdOGWji94emb2euEx838JEfiTgF6mMRUtrG+u8UvFMlNB5nVYQxxqmTVot?=
 =?us-ascii?Q?mZ6G71yEDg09WjKHXidziewvMHHZF29WwREGVzHVMl7VKIqTq7EOlGcKGfal?=
 =?us-ascii?Q?m8HScxSANIIcAbaEbkoXPRrugQZo6fS/D38r791N+5ZZdbg63T4BAg5okTm5?=
 =?us-ascii?Q?eao0Lco51cYNsU4Ue+pDaq+SEvDMLaYAoKIXKAZmyGEa4pHetERXnH1E827L?=
 =?us-ascii?Q?lTDdYxG0VPEMaW/Go2E2++Ez527/TYADjwXBMT9gst+4U/hFyVOFMCWvYDep?=
 =?us-ascii?Q?OcYJ8S10gr8UQuvWhTNaANTgFCfq0RFJ/vAm87lvA5TrOzOFOaNDCcS6AXgq?=
 =?us-ascii?Q?LCEQ0WyjKpRn363pkPrPllPu9NeeTMHOlhBDbNTRNYr8GHWDspGeuQeFcKtU?=
 =?us-ascii?Q?HlYPfXWyLqP3gsStnbObRXKojSYea58OSyt/wIk5sXC7GwzFnvf59Zh+1vdV?=
 =?us-ascii?Q?bZ6G+7wM8EwlddBO1fM2xRZM7+xFmTgtSo5oy5wH1hm82HmQItJx43E1f7Q3?=
 =?us-ascii?Q?qjnKw5fMOt4bXsns+SvBDaAkEgXIc60WtChgfcsp/6kOyDSTZquiHEaKTDm/?=
 =?us-ascii?Q?IsKIUzYlpgY44TIH/AEogFF32BL7IyH2Oq+5Dxbs+gEexg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c40806e-b626-4677-6004-08d9467d8627
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 04:11:58.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS+d8QNs5zw3Ioql1Rb0yK+5QvNcraH5tqCyOpC9Jh5P/bb7111NtTgbOke6cGYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3126
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Z2yjnA7qmlXGd8DfPRNcRgNDwbsINFpy
X-Proofpoint-ORIG-GUID: Z2yjnA7qmlXGd8DfPRNcRgNDwbsINFpy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_12:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> Hello,
> 
> I'm not sure if this is the right place to report this bug, please
> correct me if I'm wrong.
> 
> I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> it looks like the bug had been introduced by the commit
> 
> c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> 
> It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> was performed with the latest xfstests, and the bug can be reproduced
> on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.

Hello Boyang,

thank you for the report!

Do you know on which line the oops happens?
I'll try to reproduce the problem. Do you mind sharing your .config, kvm options
and any other meaningful details?

Thank you!

Roman
