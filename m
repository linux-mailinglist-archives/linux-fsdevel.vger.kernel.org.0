Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F923CEF20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357782AbhGSVaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:30:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55250 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236964AbhGSSCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:02:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JIddVF021977;
        Mon, 19 Jul 2021 11:42:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=h6dfNe43UztjEZWZv7t1tRjSf+bAAPIcDP6rCoYNNig=;
 b=QayKAOXcFS3cPeLswQVqlds1/JDNrUE3E8gSwgUavfwW3G/GPBn1XEHIo/P72Gge5J7J
 t7gHEuRaX5NNPlNrPvSnu93y9tm+XxbKpJbfHBlrQGgtXYPrC47i72km6p/a+mWedjaQ
 csEtThTgf+ot/v1j4PmpEz1yDTTzoKWOo1o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39vyt4mmp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Jul 2021 11:42:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 11:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+UfCu7pYlXigbj5yabc8EQMQo8iP+kTTS7CGsxrnq438daNbsv8yYg20RnFXydstEAUaLgCsxnMg8zxZjvzcydapnqFxaAibIuT8H43YhwQ0xHKpEaPrgH8/L5Xos9WXKPeTNE1cIQO7O2ubYEH96GahqvOie2Lk5qTl57ueASy09ViU16+4Dqx+VNy5d76RAi6e+1RIHCpJcF7At1aW+PlwT9fJ3+NQdnFDP0wiSSfeehCg81pNaO7nMkQKe9bSUf9RosIxMipl2PdyggiiktAA4ULboH5e0N4jqA/4LDTCABGe7wBw6RNL/a9g9Ky5wyCHMTvjr7/kyCZlHAEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6dfNe43UztjEZWZv7t1tRjSf+bAAPIcDP6rCoYNNig=;
 b=KMgmztY30QMjukaP3BIIYBe2CHj6KLLClMQoLHD8GFDGc71fGx+ovfRsk6zEyWbY/a1N0T8oKBFl0w59gc5RmAXpZZTaRaTHzJbnN8maPgBiqfEZwYDD1LqCJvBRcI99jXWuV7trkwDV/yOhaedzCISdAkweeLUc8QTj4CRQh00TSSmP+IegpDZFSr/JCPHovOrNuNlLy1Pd1PiCCJV0NPVi7jItyoT1jh4ZqH8qqXYl7WCy2mEPROBgWpQ3nJTdGqzj09lWsuX6SqCIuWdTK0EQMiLeNUxnJI+74AjLzokM1pXns+Ed/UgkhV5C37SveG25gxH2iTj2wMBNymM8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2712.namprd15.prod.outlook.com (2603:10b6:a03:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 18:42:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 18:42:45 +0000
Date:   Mon, 19 Jul 2021 11:42:42 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] writeback, cgroup: do not reparent dax inodes
Message-ID: <YPXHokLyedlmdrZ8@carbon.lan>
References: <20210719171350.3876830-1-guro@fb.com>
 <YPXAxo6YzR8Mx/Bm@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YPXAxo6YzR8Mx/Bm@casper.infradead.org>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:a191) by SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Mon, 19 Jul 2021 18:42:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5393f367-45d8-47d5-9894-08d94ae4ff98
X-MS-TrafficTypeDiagnostic: BYAPR15MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27123755232C3AB3E260D802BEE19@BYAPR15MB2712.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fzl4BO09zn20zef07wiRZvjgGsxdouS0EqNhUEdPbXjlQhUgXCLLggeP5iFgG7wqiP2WHY6+ga8WtIf+8REIq9NBDqqrHeMC0moA48tmwxRURmENPol8t5Csxtise5LqxzDdYgXfrxr2WkpB7wjH/z/dRRdUUtlm+hG9pKqR1wIefk/B2+AiaF8YDI506uUIsgDSthyQEsXvOd3t5KQEtD9DITeQtRJkbtIFhDEHn18Tnz6PjmdjGO3fAyrStE+Pj9tadtqFxzfIQfjI1bdTS2j86ZYAM5u4wHUsuEk+FzVdcYYaSJAGAov6dHjLqcckiphrWm1sAzrIdLr6YWifE9et3CZL+Qtz3eKd/BykLW2ORPeitCSOuyc3sNXoCxXJ9wpkO3WT9QcAWLkvxf/OGTlDG/75D6ufdqOzyjf/qzILvdHT/tBCaf5fwL3XF/IAkhs20BB4/Si27EFRqnZrn/24wJQ6cw0mpJxVgqmTUnAp2G5fh6n8EegIPdcCTWcV+3Ls7RKR61ijGe5x3noWVJPzxj1s9NlU/QTHq6SBRJcoZxfUsgWGOI1PBue6p2vooUyCnqPGytxsoaFsaE1lukPHjyHEiWKaacl28Zxm8MeiPecHKu+Pj2X/bKyadxHM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(316002)(36756003)(4744005)(9686003)(86362001)(8886007)(4326008)(186003)(7696005)(2906002)(54906003)(508600001)(6916009)(6506007)(5660300002)(8936002)(55016002)(38100700002)(66946007)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwaQe51A8E+DMKRTKou/Bqts6u9vBTCiZet1VzBB9sevFaqXBPVcGHuc+m2c?=
 =?us-ascii?Q?oPhrqj2Vo1aF/05szHAGOtJ0V3dnxlVwIeEulNXCCLtfAnIy/vyfFFvPBkxP?=
 =?us-ascii?Q?UF+6ZqIKOCd5CUvfdep50lO1sNodl1hrGuTx5Bjv4dwxqE5T5/8MvNy//OXY?=
 =?us-ascii?Q?XyFuHRLay72YiJ11DTPlYUun7Dmn0yC4bVWk53QSn0Gyhx7HRiZ1Hfa9OQ46?=
 =?us-ascii?Q?oyvTg5KKHR4wxfAaKNrD+Xib5K3Sd8tnT/+AONSbJvY+yYPO5XU/QHwydUDW?=
 =?us-ascii?Q?e2f67vQRndK+QHqdyY54I091sZ0AHSnU4fVztD5wG6hbArHhduB8/g6TlXWD?=
 =?us-ascii?Q?MferJjsDJ7ofgkzkvmbjx+Cvy4nZUP0vM3j3gkGVE9/9nUfgss4DYbiEbvfH?=
 =?us-ascii?Q?6cvCRslyHIZtR3p/U3tu4mpLn43kmiT1Teo6uASaLMijnsl7mHIoKCdM5DCT?=
 =?us-ascii?Q?xBIWkcz98AyvKe2idZyOrpOW1lSOXRVi5B6E31fdOiTFncboff8pzjjT0OYZ?=
 =?us-ascii?Q?qYFT26JtKRULcH/BeKr1LYEvxpbvQTVAJvNmZtTNGZJ9cEKG+/GhtudiYkyb?=
 =?us-ascii?Q?L/zD8EVmCd1trh5/sliT+WqtO4RYHNfSy63b4vs6xfsQwHcIPaL8WP208R9U?=
 =?us-ascii?Q?0HeeROBSzjkSG4lNzntOdHz76sOEiB3Wk/68oNVcQlfvrOz+qJvh6BKMdmE9?=
 =?us-ascii?Q?mc8/psg8KX21v8LIf7klqqllNUkfGmv+TDF6X5fXfw5OlmOYFPu6WdEn2eL/?=
 =?us-ascii?Q?cAFnJxI+zrNTRHhFLgeMrdwH9pBog12aHjO5ViTlKzMGixe5IgJJHmsnwnU9?=
 =?us-ascii?Q?xXbWQJD1jTidh4gj46Dr/VMjJoNoJG+WLlxAMyiTVkQt/k6DclE7/HCzG70l?=
 =?us-ascii?Q?uKf8n2zKRqIKX6ZKYCbd5uIB4ZldSTj1Fmcas3NS4u+f4IZELZj+WtphCBkF?=
 =?us-ascii?Q?OywVpuP3LFnzpcFOaMTJjcQevv2L8VEU5ujFUwUxRWEoFzCOlqUDRo2o9l96?=
 =?us-ascii?Q?stBAIFi3NDzHL4RFY0tekwmjqVDC2CXZ7y4+sUMUSjh1AKAA/Wf4JdUBapXd?=
 =?us-ascii?Q?d6t4dy2vWxMmxqI/dhN6G0KNzhPpGmqKUJS1XuYYdXUT/UnrACbwm6wikAjC?=
 =?us-ascii?Q?tVHBw8f3sYpfPsNzQYwILMSQS52EbWs+yU/Z8jwovl359ewtgvMO7dNeJ1Rf?=
 =?us-ascii?Q?Ofc7M3anunU7zrglDRqfYTR8tUmTQxT/+i2yCjAa+fQbM8os4STSaM+xJn2r?=
 =?us-ascii?Q?w8IfK/MgvoLO2lHJFY65XB2DJn99USL/1AhBTg6RqeJBbYc1sLf/KDgHboz8?=
 =?us-ascii?Q?SmvoDzz3YjKAQ8LGhYHX72T4EuFfn79EJZS+5VVMH9iiqA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5393f367-45d8-47d5-9894-08d94ae4ff98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 18:42:45.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq2ClsSPsrPSFM96R5S89UPiuitkBK0MmhUqdiCggG6xpGohaMg0+47kheUV5dNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2712
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qGdIwYBSoS0IILHjXDmbUmkl_0jXQQHT
X-Proofpoint-GUID: qGdIwYBSoS0IILHjXDmbUmkl_0jXQQHT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=677 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107190106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:13:26PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 19, 2021 at 10:13:50AM -0700, Roman Gushchin wrote:
> > The inode switching code is not suited for dax inodes. An attempt
> > to switch a dax inode to a parent writeback structure (as a part
> > of a writeback cleanup procedure) results in a panic like this:
> [...]
> > The crash happens on an attempt to iterate over attached pagecache
> > pages and check the dirty flag: a dax inode's xarray contains pfn's
> > instead of generic struct page pointers.
> 
> I wondered why this happens for DAX and not for other kinds of non-page
> entries in the inodes.  The answer is that it's a tagged iteration, and
> shadow/swap entries are never tagged; only DAX entries get tagged.

Indeed! A good note.

> 
> Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 

Thank you!
