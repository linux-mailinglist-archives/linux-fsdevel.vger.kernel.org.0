Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABC512B70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiD1G1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 02:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiD1G1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:27:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF477486C;
        Wed, 27 Apr 2022 23:24:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S65FUR032176;
        Thu, 28 Apr 2022 06:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kYjjmC3dt28EfMtGYw/JS1jRGSYBuM4Qny8vN/mqdhM=;
 b=GjzrgSBYdIhmcCbkq2dgaupAafqJRRx5AljZIgRCHu+bSQy2RKBt3py/rqxCJkB1+XDK
 qiJzTZwkXAp/sL0gb8YrmlxY6hyj8c4Bcy3uljyF7/XgXJ1xmJ+sr0Lx9gezK7YeubRy
 rlsN42ieodrLrfIwZ1nV3YQdpbXgV/15f1KNUIWzI+I3Er0hk0mSdUI/k58U3lTR+Q6T
 3gfRxH6rBVnl0bS9GNLiQevoh5czSqs5osjwqarQK3Wmw3i4OGQes0HkpR8MgyQXPJhw
 imnsJwG6MFoc7BN2Txsq+Kg2s+i5dnK78aa2ptElIDWZMON7yhm26qbssks7Y7ynVQrl PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb102j8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 06:23:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S6Gcum010024;
        Thu, 28 Apr 2022 06:23:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yn6h15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 06:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWVMUPxODLGdiEop2SP24Ki/zuYHAgA+hirvMSlgB8GITJ/TqkEH7Xj1Oz2hspdDxVhJ552stQsWo+YcLYXaf8hVGXGX6q/XIlbHt5iwcKtPTbbqFuc6V/ThgQNsgN5nS/PvGVyOWdN4kvu9i4Gl15J9bkzcgLKQxYNzk57y7OI+QY710zXDHjGes8OvhLwUEXurSHPgDc6NZrTRzqYi7U3MLDkkUIsZOP6Frx9mIlZ7hJ3QJseURLA9R1jUnlfGYWJsxIjoKWry85KjfwYK0Gu/phcqSCmjLbprYVSuuJp8x2otXifzzQd9pR+ZMMOQBfw0tBNuwjXRlJlmW7mjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYjjmC3dt28EfMtGYw/JS1jRGSYBuM4Qny8vN/mqdhM=;
 b=isTJ9JgVtegr63FjmSyZ25GQtG25GNS8I8567GvmywdzPxg44fZzQy4Mw9Z7uDv5IhIBImLGPF1921UCPtcGyx1onZCBnN+cKSf6UvVlDlu4Jsn2EFsjumjzy+QPRoITfm13WbB+gBo/pxqbPAPF1po11/aXApDmNCB2kVH8a/8rLIpIHlwrtOG1v2uEh5Qy84dOS5DeYL7y/oXlx6tUZJxaOfO8EOUOk3H5VhUgZFpoleLbHCVyiDY2Uqu88L48etcyTf3I0m9/qtX8Hv6FdygzLftyNdDXIXQh06nMSk4d0xFlqSRNjMOI8W+09S8TS3FS9kQ0LrfDP7khDKWu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYjjmC3dt28EfMtGYw/JS1jRGSYBuM4Qny8vN/mqdhM=;
 b=Phz3X+d1qnuLv4bykNxLnL7IGjJVI0N6OLbIZLDiwrSGa807DFoKTt2mhSvfIRt3JfhTuwGguug0INSvGMBadZZ8f73s7toRXobfgP3LjI3xociHoMB7fFUfR3DFikpj8AcGrGuLVwJmtOQGde6waXYhTeHe97b8ak80ypkmSOE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5748.namprd10.prod.outlook.com
 (2603:10b6:510:125::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:23:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Thu, 28 Apr 2022
 06:23:53 +0000
Date:   Thu, 28 Apr 2022 09:23:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_nentry
Message-ID: <20220428062340.GT2462@kadam>
References: <0000000000009ecbf205dda227bd@google.com>
 <20220427125558.5cx4iv3mgjqi36ld@wittgenstein>
 <YmlaCVrwvZBlOWGO@casper.infradead.org>
 <20220427151715.544aa2om5o7pp77n@revolver>
 <CACT4Y+bCyji6yxtOgJg05pkiNnqUAptW4Qdc5EAZW9uCUfjwCw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bCyji6yxtOgJg05pkiNnqUAptW4Qdc5EAZW9uCUfjwCw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4287aff2-d69d-45b7-32bc-08da28dfaa4e
X-MS-TrafficTypeDiagnostic: PH7PR10MB5748:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB574832B7C04DC137A403FE838EFD9@PH7PR10MB5748.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euq8v/QzyFobp5AbbsfpmoREexOJWKLiLk71EXleKed+iWjN5z1yCd+HURDxmPwxLHMARbbVR/nJSF/A7M/jGcGj4IqJHN2pVehukBzzcoeNIuzRfnoelXREy98wD2/RohUimjWgBOuc3wObGVvBLO2zAw4UeWkdJsUceE+ZNYLxn/2aek1xS1Pci8+orJiCe79foLhET3Ioii14RksJRXMG99e9DliS6bZtuj6U++7WiDLfuWnko1EtmRBYU3GwsHPIqZX2WuQAy2PKVyyoNTVDRaXtxqghS0fM9xZ9NzkxOc2qsC7oouQ27OyyACvqWuGp3XZm0SpL7kcdDZfBS3itR3vh9mO2qSEOAKb5BIXaqiePvUjZ6Y9v8CKuZWridwswWuN4LQYUUP+8v1NDn4IcF1ZUb9ax8cocIZB0C1GRcpn4WnAkv6S38W8F/O+toOXg/32B2OtvFarPlSCV8JbButrbS4qEPOHTBsSd3Vbd8hMLxPnbY1zQaZcXm2aRbxpN+MfhG9JHfYNGxm92hXLFO+Y4VFQkSs3GcLsTvJ3QxQQvuWXlzmjHv9Um9KpyRv/jnXkOZuO7VlPxmmR7NUwUWfGyVgRppbQlhmOKI98zmsG0oEWjfQI1Zm1CaNRjOpzgM50YYib3omOwX6Bjl5vh6kBb8Cnb+uOuPKNRct9ST/QdG7nyO0z4WcTflEFv8FsOXp7nhchXq/tP/nlVjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(66556008)(66476007)(4326008)(8676002)(66946007)(5660300002)(38350700002)(38100700002)(26005)(6512007)(6506007)(6666004)(52116002)(9686003)(316002)(6916009)(86362001)(54906003)(1076003)(33656002)(6486002)(2906002)(33716001)(4744005)(44832011)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATm1fA9N1ERGtUpp07B+Q4zEFtPRnUTayiR+OXdZDhCBcAikDhCd2PFUWdve?=
 =?us-ascii?Q?CQA8LexMvWvmQlbHTH+fWWlCeKvluW6FUcOZlKs2AiBO0os2J2hARbk03fjC?=
 =?us-ascii?Q?QLUO0ImKsRAWWN+vouJV4CWF1Eoqbqjky9NQAn/UIHTqKmfir9NSTMhLyacx?=
 =?us-ascii?Q?hhH6BNrZBEgT0Xk9mSy0W2LzuensIDk3jdVqDQI9LE5NLHm5B1C+0xHnX7Ic?=
 =?us-ascii?Q?i0ZyEJ60I2NCgi+T1Zc/O6oyHW77v3l0X6QwY9TzkAzHsvaMWZQYOXzVJI6R?=
 =?us-ascii?Q?2OdDm73cB98E+sKHG//SaxhXtga1P69N69sXDX8VKiwtE/L9ZpjCmzdyNs/s?=
 =?us-ascii?Q?HnUXZl4MS9oj1yFoDYeubow2PX4LhdTvnITEx+lw14Njq7Qli59e75Gjufp/?=
 =?us-ascii?Q?sZnqn/Ez7NU0M+lKrBm5SOQTad9nJlHkDca/AW99qJINHh6gP0urfyEcbuKi?=
 =?us-ascii?Q?Ts/1mB6AFcSyx01h12T1PHr2yFBWkQf0VLRMgVJ8/S54t7O7pDu1R/A3AXjN?=
 =?us-ascii?Q?xNpKAcZCeGTbJKBFsyFDSznlbArI2AyNC6G9NiPMregrg2m1oCM8t/kbFcq6?=
 =?us-ascii?Q?TvoRrY/Qzy2iGWAevFgyKVVTyrBc/0voCbTp0vTWBZ6SKMcv3CimPmzx0Vl6?=
 =?us-ascii?Q?LP+cfCCVcdgc8QxlJUp1oDimz+wc5ie9M5aqCk7bqAno3vvbzTgC3NL0sT5j?=
 =?us-ascii?Q?MTtNh8Hm+ccNg4Y0xB98aZF6+rSzch9XuSuwUcUzHgq/cYSh1NzF+j/TPei6?=
 =?us-ascii?Q?yt1nTxh68FtJBaixfqRCtPi1FNXJ1D9fisDW8jcJkZEeQtgbz/FZQzQH9ONY?=
 =?us-ascii?Q?FeX/ZMcfH+MCmTcINZLmjAKY8NRdWNcYOV6QdHBe4pfl57GsgMci3NxPzIUQ?=
 =?us-ascii?Q?qzBYuiNbf22fFp9Uipo48p1VXS5dQ/BwuZ765sf7yl0s6/g+fqEx6XKy5edV?=
 =?us-ascii?Q?RmRYi8k4GQgAFNu0fe8PhyGxNGAfgRp99lvi3s7znzIZA89CMwE1/E8/9Dk0?=
 =?us-ascii?Q?WFjkr5WB2xUjwno6O1uPxwKgaIpKWc3KJTK5ufYNreD3yMHu1rIGMLlavOUq?=
 =?us-ascii?Q?sbPNKvwKGDaFLKcNUKsSQX+rMWF2wQ37Gb0E6dykwisMgZbYZlJiGNXWCwkm?=
 =?us-ascii?Q?fvJCI5wn8NKbAm2OEVhNNDFsqPZ0YrqFgJNPpD6q6+HXR1nPMnRSf4sUNvH9?=
 =?us-ascii?Q?bxT63n9v0uHqjYCJCbuwcF03NBhM2RJjUvCHWwy+eKmrEhnWl++7YX8ONHIL?=
 =?us-ascii?Q?/526ZBLrf9NJKw8T9oaaAXgE2hIh9JAgCPU6JrnAEXPTe7DuIz2pF2FEWtMU?=
 =?us-ascii?Q?EHYD0Kr0/fuSgnosPS0qEtOWjLoW2JSuhecSwQ5C8qjT6mC1ulztwj6CMxE8?=
 =?us-ascii?Q?mUSj2HBDgdWvpEYLewakVzAHrtoB4mnCmbtvRQIFF1mB3FghUwOFmWa0UNG+?=
 =?us-ascii?Q?ap01t/zMLd1OF5pCxEDsF2GbYGyXfaBi1bUzEmsLjE8UIQwEf/6nTEQIoE2w?=
 =?us-ascii?Q?Dj+7KsLh8UJ/H4sT8gvjHyC4FBLq/Q9jjvaFV6VZh8IkHpljzjq3S+5xrcZF?=
 =?us-ascii?Q?sz3mRxEyb1jeg5C2bvtT/8kE/RTuecX0/KiNGagrLhgcHkZct98+3a/q9sVx?=
 =?us-ascii?Q?I5lAhF+K9Om00a1CU5fEEHso+WBh8YYrHS8xSMVGy80r67I73lAS+yNNH9h1?=
 =?us-ascii?Q?sgp/F10MpchUJ2nW12zAWriw7Ow76gpHm1gqVSploBElgcHna/vEgb+9bsiN?=
 =?us-ascii?Q?8ubHFUYETK8nZQcPZEp4JDNJFb97KBA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4287aff2-d69d-45b7-32bc-08da28dfaa4e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:23:52.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVwsmb/L4DiOd2ty7B8al3Kr+fJ4bni8IsP4IipeJH8BZyUaG/lL2Ib0izWmi8hyX8aibfr7bFYbSsG+0RxuncWLaE5rNybZRn9YVzBtttQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5748
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=842 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280037
X-Proofpoint-ORIG-GUID: iiD6TQ1quwiuZsCf8Gr2XI5ZQJQ9sz1b
X-Proofpoint-GUID: iiD6TQ1quwiuZsCf8Gr2XI5ZQJQ9sz1b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:22:31PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Wed, 27 Apr 2022 at 17:17, Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > * Matthew Wilcox <willy@infradead.org> [220427 10:58]:
> > > On Wed, Apr 27, 2022 at 02:55:58PM +0200, Christian Brauner wrote:
> > > > [+Cc Willy]
> > >
> > > I read fsdevel.  Not sure Liam does though.
> >
> > I do not.  Thank you for sending it along.
> >
> > Here is a patch that should fix the issue.  I will ask AKPM to include
> > it for tomorrow.
> 
> Please add the reported tag:
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com
> 

And a Fixes tag as well.

regards,
dan carpenter

