Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856AB17857A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 23:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgCCWRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 17:17:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12682 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgCCWRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:17:51 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023MFRWE032483;
        Tue, 3 Mar 2020 14:17:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oeiPRpVowtMN7tTumZLA2VCI6/Dh9OLasJPzFeiZYQE=;
 b=Va1fmd4J4nvG1RxhkMD4/vQFigYZqJGAXzFxfVSYKZuau5v9AfqG9UWmoEptlqFYoFFi
 XIEbZiTqAJEkM01/vgZFoFruajhD2nphAARVjxJqpSP350F1HJXATHrTbLc+w6PJGQCV
 qin9AgN5Dsq0w6r40HMf9EQJhCnbHMwhu4s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yhbxwnsjn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Mar 2020 14:17:39 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 3 Mar 2020 14:17:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeV3QIOLSt18fnuYPK8KHnInK/16iTycPaKOrP0T7opJvDpT4RkxIhOO4tXZKoToDWsKgt0GaavPmPpEYqP9dk11JEy7QJx2hqW9YhUjJvmgFTa+4fRZnVoYZ5IwN3A6/EJAgRgKKJqAA0YdtqB7v8Ai1FNI5LZYuwL+9xBYcANa4Pdj39m5JoFlpCVkBuS4/HNqwVbBQgwMoIqFToYUQMl/BHZVUYv9ynKX2cLOZLPGua60dpgFRP18XuLNNsb31JuzAlWH3iJ83N1OBEGm85LiCkKv0z8LQ+liPGHf9jLUQGUtFZcvsSBeq8L+mdQNT1s5RBPeoKmZ1CWict5vmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeiPRpVowtMN7tTumZLA2VCI6/Dh9OLasJPzFeiZYQE=;
 b=m3NLd62LwYTCo9IHh5lQ5ZczV8F1TXHyO3QYVjP1p0BdHXZQDVAPTX2pIVU5DUjy22RJx1JW5Q/Vs77d5Eb/QpuGdxXm89XQeTwFVd9Kc/2UjgMayZN29dAHO5dSwi6DDSrSSX+YbU6EAdfzdMLjR6d9JNb6Sq6zsRIsmezO0Ri/Y+TlcQRD1OoVNKbefJusNSXJEeTI4mBFU1N1d0vvIlKtk/r9OjnIRdkramWJE9mtETA7UD7bLbFSZ/ItyYiCKLexH/mTM3jm5TpR+QTgpdPYP7WfzG/5bZQD36/Z4yp74xjMpOQhMLSoGqZzqsPPMKyL4oq0NZfqDAFIWRK33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeiPRpVowtMN7tTumZLA2VCI6/Dh9OLasJPzFeiZYQE=;
 b=I6Y/yrMKq0Iqalgj84K+F/tAZ84tvAk6Xeolnj/5HEeXAdD6ULT5DXmGY756h0klDbTKuOQgputBcT4irba26tHDfIkm/QMUB8jzOoGWDOt/gnE6BlNbhS5mrPyjXX2Xto4DEACFuFtwB7yO5iO9OfEjsNeniDlexDW2u4Txmdw=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1951.namprd15.prod.outlook.com (2603:10b6:320:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 22:17:33 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::90a5:3eb0:b2a8:dc5e]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::90a5:3eb0:b2a8:dc5e%11]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 22:17:33 +0000
Date:   Tue, 3 Mar 2020 14:17:29 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Theodore Ts'o <tytso@mit.edu>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: use non-movable memory for superblock readahead
Message-ID: <20200303221729.GA722016@carbon.dhcp.thefacebook.com>
References: <20200229001411.128010-1-guro@fb.com>
 <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
X-ClientProxiedBy: MWHPR1201CA0008.namprd12.prod.outlook.com
 (2603:10b6:301:4a::18) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::5:cf7) by MWHPR1201CA0008.namprd12.prod.outlook.com (2603:10b6:301:4a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 22:17:32 +0000
X-Originating-IP: [2620:10d:c090:500::5:cf7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d901be-8e05-4d0e-9f1e-08d7bfc0ab75
X-MS-TrafficTypeDiagnostic: MWHPR15MB1951:
X-Microsoft-Antispam-PRVS: <MWHPR15MB1951CAD29B2BC78B468B0553BEE40@MWHPR15MB1951.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(66946007)(53546011)(52116002)(7696005)(66476007)(6916009)(81166006)(81156014)(6666004)(6506007)(316002)(33656002)(8676002)(54906003)(55016002)(1076003)(66556008)(478600001)(9686003)(16526019)(2906002)(8936002)(5660300002)(186003)(86362001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1951;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUvMMA+i20aa9E41YG17FQb474X4yvx/MFvKzXDX5z8PsMv5DuH7on+2LDTudOqXCVzzkaPnSeMlkdTe/G2beBnSJaFSG+iw8HIulDZl2iBmoPoomEZYBjtEYcfyHv3oy/whiETkeH4f1J/LCBZ6sGI0noyQILaqodsSNqYlpP5vasYDLESzCcrY2VCh+QKjL7wdIysixH5uvDC9uEXnIeGmUvtvK19XAVJk5dLTcrkKIq8DTM5ol2KMFTnVwxbkC9QpHEh5LwxzCq/NYvnNhlBEdTbxhPAQSxVhorMMiihH+D71Fp1WRpmKw+MpLdVIvLDfSFKF1AfyBXXlY5uhcld1oHkK58jwo99FXyCnXtksYWjypMtxcs5aw8p4sXO5zwbPgyfhTTV0BpWEUz6poLin7/d7YYz1KRU7+q0nPPwFLL+EppNgwRnUUNC1+6BO
X-MS-Exchange-AntiSpam-MessageData: nWeGk7L6jTLmKDLiidFXtdV8ebJE6rzPCxxpUE1ulrGRHtJzdOLjTjA3f2nv/TcXWlCLz4HR5ipp4BlZJvoHc9A8G1f82QmXadoaGBidxlg4GQHYcvQgLhvJkvODoFoN2XsUrrAFjQPBPg/jmwpaYof0MeMOKrZNr1t6LXbsqHHEm6h114vKve8Spmpumguq
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d901be-8e05-4d0e-9f1e-08d7bfc0ab75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:17:32.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR8tbktagvFcLi0imIpM3ADNlK/uncPr+BjQSrtonfVctQh7ja8tSIYIWVNpiGBc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1951
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_07:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=801 bulkscore=0 malwarescore=0 suspectscore=1 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030143
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 12:49:13AM -0700, Andreas Dilger wrote:
> On Feb 28, 2020, at 5:14 PM, Roman Gushchin <guro@fb.com> wrote:
> > 
> > Since commit a8ac900b8163 ("ext4: use non-movable memory for the
> > superblock") buffers for ext4 superblock were allocated using
> > the sb_bread_unmovable() helper which allocated buffer heads
> > out of non-movable memory blocks. It was necessarily to not block
> > page migrations and do not cause cma allocation failures.
> > 
> > However commit 85c8f176a611 ("ext4: preload block group descriptors")
> > broke this by introducing pre-reading of the ext4 superblock.
> > The problem is that __breadahead() is using __getblk() underneath,
> > which allocates buffer heads out of movable memory.
> > 
> > It resulted in page migration failures I've seen on a machine
> > with an ext4 partition and a preallocated cma area.
> > 
> > Fix this by introducing sb_breadahead_unmovable() and
> > __breadahead_gfp() helpers which use non-movable memory for buffer
> > head allocations and use them for the ext4 superblock readahead.
> > 
> > v2: found a similar issue in __ext4_get_inode_loc()
> > 
> > Fixes: 85c8f176a611 ("ext4: preload block group descriptors")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Is it good to go?
Can it go through the ext4 tree?

Thanks!
