Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD073D20F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhGVIvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 04:51:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10722 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhGVIvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:51:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16M9QkrD003284;
        Thu, 22 Jul 2021 09:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EJXlh3agoLOTbWCR2enq0uWyobGdABwRCH1xEoFun5E=;
 b=DkDXUML2nJX69lCj99MnE8QiFdK9qLts5I/RegnvG2celJJhno70znQRPzN9MaJo1EAy
 3z+vCZYQfJPLKHcD8Yt+OTYRrh5S8E0PVJlxlv5fQdOBxMi8+OQHl5dGwKNcEP/cundy
 RsrkyieXmbjA1yNgIoLHwH3ikxpqgRf/HEuHU6eLb68dAis25RMEYPVGWjIKoRvrSDHH
 OjIaR10ngwid07b84LzibZy5kZvWhQE+GtarQqzabH2QOtT1xOW3mjtlol36iB3MPAD+
 CWEmB3rvipREVJo7wuXOnBkvCUFIoGeKTb1d5jxgBnr4zBCLw/FNMbJruqpk6x+HAe0L nQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=EJXlh3agoLOTbWCR2enq0uWyobGdABwRCH1xEoFun5E=;
 b=oODxNZJAhM7aX4RlnxtRNxaFL5JSMv2KZEwfpAV596UZsrJaDUAVB5yFQC/HvJ03OO3C
 MgAwLMb+/MVUNyCOGYkn0OkQ/zdNQ3BBDuJ9LQ7XEjL2XeyFc7lACsdw+0Jo20UAXIA0
 RMtaxIChfFoYksMG177xkOR67RJHgPaCs8uSYCQez5fjepzGlnkfQRk/Ir/Cz0FeKdSh
 1yDvkHhw+cvEGxNjhCX8SS6+9Ffpsed8ksEiewjtCPbJU+6OnFd9I00+jDJgaQSw35an
 JCdbIK2XIpTu8ul+4U39yGSRG2uXCo8xrXouMSsVPC2QgrCwkvz5U99/vvko73GpnOTI 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xvm7rvr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 09:32:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16M9PPLY128165;
        Thu, 22 Jul 2021 09:32:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 39wunnmmn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 09:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKQ9Fegvz+tMsf4KbTHMcYuqxRebOVm34WWzyAKSM69p9yEGDWYYNXKz09CC1rzLI0wrUV1HS4skJzieS4DRe85vpm+kpX0uP2vAN7qlSUusfLA9Ik3Dh7Dp8YHWpggUmTzekn931BZaTgeWRFpyuw+vIN6hpiPzmE4NvoiL4aXFI0i88WM/ebE/wwFILLLfp00tz1IlVbyKEwEdjkQ4+6YfefSc3oTVhh6BQif+/Xghjn/LdqVauHpVHfReps6TGDMpLG1MGKI2HZn8jpTDoGrCRa32w/2lHCIeCK5Ccb1Wa8OGqr0dU6kCyNsP31TTWnS1AH3I0/sk0OsrQARAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJXlh3agoLOTbWCR2enq0uWyobGdABwRCH1xEoFun5E=;
 b=Ja+oFjOKicN8LjBJH07fjlXhVYvGHFB5yzmDWz8O8XwmFVzncnV0M+KX73ixgbe9fVZ5wHocqinsen/JqietbKwAb1muDXErM20fottHMjWaoVGP6aQzKifPKxO53XLZ0YPLAav82PLjGoQB9pMloztr4FCDxVMZYTcT8Sqyx/DwJhwu7214RBXpbMuktyYC1DnCTJxh/5nH49jUt4ySsfNR7RTIRk/O6z3eD8FOIRDaQLZ6mZSCC9TO6LW8UNGMwE0pa5vL0tWMONw0TqwcWukhz8uReGXrVH7Ikw4+3TKN/cZFK3ztXq+tICF4dp5rNOb7yJFLgd24PVaEe1t/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJXlh3agoLOTbWCR2enq0uWyobGdABwRCH1xEoFun5E=;
 b=jevLhUYI8racBBuqvTUemYj+60dzYiVq0fl4PBVish0fW7+qJdxU3ItN1gaTt3DyeWF7cl1ywEirgRjtJIhrw5JPpT6O2kIpWr8GN5i7U31ZqNATtQBFxdOa+6OtMojoHGxNreJ6SlzQUC+xzoLG7xbeN3slgRBv0Z+T7Qn0Gew=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1728.namprd10.prod.outlook.com
 (2603:10b6:301:9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 09:32:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 09:32:00 +0000
Date:   Thu, 22 Jul 2021 12:31:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] fanotify: fix copy_event_to_user() fid error clean
 up
Message-ID: <20210722093142.GU25548@kadam>
References: <20210721125407.GA25822@kili>
 <YPih+xdLAJ2qQ/uW@google.com>
 <CAOQ4uxgLZTTYV9h4SkCwYEm9D+Nd4VX5MbX8e-fUprsLOdPS2w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgLZTTYV9h4SkCwYEm9D+Nd4VX5MbX8e-fUprsLOdPS2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 09:31:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8bb913d-b4e8-44bb-b5d2-08d94cf38eac
X-MS-TrafficTypeDiagnostic: MWHPR10MB1728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB172873593D8463B259416E058EE49@MWHPR10MB1728.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12O5xxobMy6SaZx3vhXgkJ/4ZR2J9j/Rh+G5HgaRte48oSYnPsUT0+neJvFqY8y5tkqxUvvQsn57MypvZXvQE5LJm4YAaomYelImbMKKr2a07V7eqdlmrIXWEYsGQ9rXnvEINRyaVZrtzaGWgTWHJ2mdb9LcYBRR+jKwyIflyI790mXeIc5rk57Xx46pNdbZ1uMyJQZn3mx+JWQEhmg7YeWLtG+V6VT7fmUhrQ+2TbCRgEa8Pz6P0XdGgfpcocs5iej0dnEm2hUL9coZiye5IlBFu/9au35oTfQ1JDYzEt/yLD6etdoWneWGibGEyTi+B4LapEqxzhlxyPlJBw+oVzYicjuBFPYqOc6T/7Rq+n9gNxXkLOR5VzmpnpDFnZ1ML+38ETcbvU0tp7Jx31y5U1PvBQyzsubg22vUVyEKt7dN8ECIHBeCRMj3B6ght5O9czl5QQ1c9r+WFA8s0EteLskEF1nGaPcOhwZmBjdwVTgLZmor66lDd6cFyB3Ur59YNMDLLwFgpI8ibXortgoNDG3V4cNOLO0ywqGhvvkq/AN87bmYHijxOmcTDpZMatBzIeGh+iVpliZ7hQtO5KZ1LAYNCkYOcTkJu3PpcAaf5N226vziCtPHBMGO7WhXPmSzZKpCPD4JZ2GV5juE3PgAn0fyaEFOLySPfKW+4fyU2I63LXxamhNZXzNiHiq3IlHiJUzvMMT7n7DbaT9uaVNRlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(396003)(376002)(55016002)(9686003)(33656002)(6666004)(66946007)(66476007)(66556008)(44832011)(86362001)(83380400001)(4326008)(478600001)(1076003)(33716001)(54906003)(52116002)(53546011)(6496006)(186003)(956004)(38100700002)(8936002)(38350700002)(5660300002)(6916009)(9576002)(8676002)(316002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cD5gQtff2pxAZ3FFXLdAKJPadqwns+yZgN6ctvdwbAPIutI+XeQWdltMyfZ?=
 =?us-ascii?Q?mxsT+ht4nCfSk13r16felo877x8jhg9DfSijMtakkYB1lKdSNqs8CxsvhrLy?=
 =?us-ascii?Q?I9VLV2iSNZKq1XR60NvDH32ka+ViGZaDof05BNT9XRNdKwj7QjBg/C22A4Fq?=
 =?us-ascii?Q?IN3xheperyFKFUSRjgKUjjQXHbN2eF1SIe2qawDK8bO3zAETmyq8nxWRBrnR?=
 =?us-ascii?Q?RLBBevWFb879u7A3XCkfU5clNqWxxDmvoUnNNXALgr52TPg0dK9mExgHCf3J?=
 =?us-ascii?Q?a7qHTaXRLhmwLTiH/g21VAPvppI7N75MAdKhEoIqzlNWG8ggTzKn7U//0Idh?=
 =?us-ascii?Q?7nTM63NkwTkYq4Nd3+N7oC8yAwMvmsqJE39X2zKgFCX0SIcpIsqKznDjJCi6?=
 =?us-ascii?Q?7aMt9Dqv0xaiwHuQoSvNleIMdG4aZrrYGdJYX2C+oyXhUC63i3XZiu5VG93S?=
 =?us-ascii?Q?6dPoHYe3lWDMVRQosvBCUaJQIRuj6UWm8RVJrbqkO3z8V9BYCkJTE9S7xtnn?=
 =?us-ascii?Q?ve309/m0Efg81dYJ7B43L9dkwwOwNdbV5YOohe+LmgqAifYyMK9ZUzkTlRYU?=
 =?us-ascii?Q?PTcImRBzx2L2p2K/7VkNEatohfMZHoIHo/7VaQf+0RL/GhldAwNQ7168s1AP?=
 =?us-ascii?Q?yViBOBXXWVB7HP20arzrPqLo6DstltkT3BLagellE0AOZqS8igS51wP49g/F?=
 =?us-ascii?Q?z+gnHejO2yyaIdHRw9t7u6SFctrym6IXkDauGyRwIyVJ6SDYpS/8RR25TPxP?=
 =?us-ascii?Q?Y9JPt/eet/+UtgELQ3VKiiErmVqDEG44Z3t3y6yZzR8Yvsmp7HOr7P0YubKQ?=
 =?us-ascii?Q?R1OCNt2NyH306ZAcuj5MuapxZlozl8DMDUAxwGbgr7K31aE+blxdkgHn6/ON?=
 =?us-ascii?Q?iJYSLW5JycMSwTOd8CmZ8sBevGl7Ob4twLsn9wrgjBON8oKLJZn66yBNz8WE?=
 =?us-ascii?Q?YUjNkQrbOoNkPlS57otQqEaYcP8DhhZo92ImpCTf4i/J2NZOXcjouSBp0740?=
 =?us-ascii?Q?bWad7HLCAPZCBc3Jly5Zr+jOwAUHFD7PqyeWq5vPjQD2S2YWJLeYGli4G7H3?=
 =?us-ascii?Q?eQuP256fnN7sE6PvNcGf1FRfwmmv+cqxljOUGhe6N0+BXYOft17mdYNfC7ki?=
 =?us-ascii?Q?jktciEOHLHYBSAwE5kjnhBvzfUR2tXnpL10C7KtXirQkKAG0rVXvQhscs3Yq?=
 =?us-ascii?Q?buQBijT+VehuTfVvJNSfQKhV31KclBciR+zqrENRZ1PCiUCrwUT2iWwzkFXJ?=
 =?us-ascii?Q?bWBNdBcJSuQbeInYLXN9mgiRdfjOogfafjutSxilLk5K0p7apj7MXGvMBhJq?=
 =?us-ascii?Q?81G3xTVz1U/UQVqi9wHPI0KQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bb913d-b4e8-44bb-b5d2-08d94cf38eac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 09:32:00.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co7GD1u2QP+vMWBk8WUT+7CZFGUw/Gv3fA6l9v0vh8q+KtfNJuCI7IELKvNpnOsdFXjJlTgEanmW1dPA2rcHbhe/dFl2nxa6qQOx4Kw23oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1728
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220062
X-Proofpoint-ORIG-GUID: CRM1cVe3rGM4Ju2_aVnivO6txaYW1ovt
X-Proofpoint-GUID: CRM1cVe3rGM4Ju2_aVnivO6txaYW1ovt
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:01:41PM +0300, Amir Goldstein wrote:
> On Thu, Jul 22, 2021 at 1:39 AM Matthew Bobrowski <repnop@google.com> wrote:
> > To make things clearer, avoid any future confusion and possibly tripping
> > over such a bug, perhaps it'd be better to split up the fput(f) call into a
> > separate branch outside of the current conditional, simply i.e.
> >
> > ...
> >
> > if (f)
> >         fput(f);
> >
> > ...
> >
> > Thoughts?
> 
> smatch (apparently) does not know about the relation that f is non NULL
> if (fd ==  FAN_NOFD) it needs to study create_fd() for that.
> 
> I suggest to move fd_install(fd, f); right after checking of return value
> from create_fd() and without the if (f) condition.
> That should make it clear for human and robots reading this function
> that the cleanup in out_close_fd label is correct.

Yeah.  I got "f" and "fd" mixed up in my head when I was reviewing this
code.  My bad.

Smatch is *supposed* to know about the relationship between those two.
The bug is actually that Smatch records in the database that create_fd()
always fails.  It's a serious bug, and I'm trying to investigate what's
going on and I'm sure that I will fix this before the end of the week.

No need to change the code just to work around a static checker bug.

regards,
dan carpenter

