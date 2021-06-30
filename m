Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145CC3B7EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhF3IPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 04:15:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29198 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232954AbhF3IPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:15:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U89Bfm008665;
        Wed, 30 Jun 2021 08:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=WtCBfM90EFGfs1Onij8J9qiG9Y4Zmp28mqOADCVrkrk=;
 b=eOeOIWL1qJDsbQzbQguZOEJA3aakOr68rSnzohrBzz2/H0RYS2NILS4YsbZnKUxdS6dQ
 4zB4RTYBZJxUtkXvchZGoT7RJQ7jKd6FscdShTzaO8yv05lwwNCrQnxXyhXd5vD0CmN5
 3MCeX3iAiikwZnWKHmFmI/dmRbm3Sz62r00M9CdoPr/r74rIjzkmXohuHrogjDncdJXK
 PmYnfSGYnVcSuEnMXJSr/SkOqPilFjCp7bZohUCwm307zR2NUo94G0Lr7C+Gtwdjpthb
 tBWPjX39g20/exw9Y2U5FUuYxg85lHRA1vkp7F3lD8x02XzfBSenjnglvfzmRevsWSNv Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3ncck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:12:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U8C75n061977;
        Wed, 30 Jun 2021 08:12:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 39dsc0uy90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:12:20 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15U8CEGA062577;
        Wed, 30 Jun 2021 08:12:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 39dsc0uxmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:12:14 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15U8BYEE002006;
        Wed, 30 Jun 2021 08:11:34 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jun 2021 01:11:33 -0700
Date:   Wed, 30 Jun 2021 11:11:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        amir73il@gmail.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in
 struct fsnotify_event_info
Message-ID: <202106300707.Xg0LaEwy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-8-krisman@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: SWQuY9bg46nwWIdk6jNSyXqz3-THUKLJ
X-Proofpoint-ORIG-GUID: SWQuY9bg46nwWIdk6jNSyXqz3-THUKLJ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
config: x86_64-randconfig-m001-20210628 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/notify/fsnotify.c:505 __fsnotify() warn: variable dereferenced before check 'inode' (see line 494)

vim +/inode +505 fs/notify/fsnotify.c

dca640915c7b84 Amir Goldstein         2021-06-29  470  int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
90586523eb4b34 Eric Paris             2009-05-21  471  {
dca640915c7b84 Amir Goldstein         2021-06-29  472  	const struct path *path = fsnotify_event_info_path(event_info);
dca640915c7b84 Amir Goldstein         2021-06-29  473  	struct inode *inode = event_info->inode;
3427ce71554123 Miklos Szeredi         2017-10-30  474  	struct fsnotify_iter_info iter_info = {};
40a100d3adc1ad Amir Goldstein         2020-07-22  475  	struct super_block *sb;
60f7ed8c7c4d06 Amir Goldstein         2018-09-01  476  	struct mount *mnt = NULL;
fecc4559780d52 Amir Goldstein         2020-12-02  477  	struct inode *parent = NULL;
9385a84d7e1f65 Jan Kara               2016-11-10  478  	int ret = 0;
71d734103edfa2 Mel Gorman             2020-07-08  479  	__u32 test_mask, marks_mask;
90586523eb4b34 Eric Paris             2009-05-21  480  
71d734103edfa2 Mel Gorman             2020-07-08  481  	if (path)
aa93bdc5500cc9 Amir Goldstein         2020-03-19  482  		mnt = real_mount(path->mnt);
3a9fb89f4cd04c Eric Paris             2009-12-17  483  
40a100d3adc1ad Amir Goldstein         2020-07-22  484  	if (!inode) {
40a100d3adc1ad Amir Goldstein         2020-07-22  485  		/* Dirent event - report on TYPE_INODE to dir */
dca640915c7b84 Amir Goldstein         2021-06-29  486  		inode = event_info->dir;
                                                                ^^^^^^^^^^^^^^^^^^^^^^^
Presumably this is non-NULL

40a100d3adc1ad Amir Goldstein         2020-07-22  487  	} else if (mask & FS_EVENT_ON_CHILD) {
40a100d3adc1ad Amir Goldstein         2020-07-22  488  		/*
fecc4559780d52 Amir Goldstein         2020-12-02  489  		 * Event on child - report on TYPE_PARENT to dir if it is
fecc4559780d52 Amir Goldstein         2020-12-02  490  		 * watching children and on TYPE_INODE to child.
40a100d3adc1ad Amir Goldstein         2020-07-22  491  		 */
dca640915c7b84 Amir Goldstein         2021-06-29  492  		parent = event_info->dir;
40a100d3adc1ad Amir Goldstein         2020-07-22  493  	}
40a100d3adc1ad Amir Goldstein         2020-07-22 @494  	sb = inode->i_sb;
                                                             ^^^^^^^^^^^^
Dereference

497b0c5a7c0688 Amir Goldstein         2020-07-16  495  
7c49b8616460eb Dave Hansen            2015-09-04  496  	/*
7c49b8616460eb Dave Hansen            2015-09-04  497  	 * Optimization: srcu_read_lock() has a memory barrier which can
7c49b8616460eb Dave Hansen            2015-09-04  498  	 * be expensive.  It protects walking the *_fsnotify_marks lists.
7c49b8616460eb Dave Hansen            2015-09-04  499  	 * However, if we do not walk the lists, we do not have to do
7c49b8616460eb Dave Hansen            2015-09-04  500  	 * SRCU because we have no references to any objects and do not
7c49b8616460eb Dave Hansen            2015-09-04  501  	 * need SRCU to keep them "alive".
7c49b8616460eb Dave Hansen            2015-09-04  502  	 */
9b93f33105f5f9 Amir Goldstein         2020-07-16  503  	if (!sb->s_fsnotify_marks &&
497b0c5a7c0688 Amir Goldstein         2020-07-16  504  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
9b93f33105f5f9 Amir Goldstein         2020-07-16 @505  	    (!inode || !inode->i_fsnotify_marks) &&
                                                             ^^^^^^
Unnecessary check for NULL

fecc4559780d52 Amir Goldstein         2020-12-02  506  	    (!parent || !parent->i_fsnotify_marks))
7c49b8616460eb Dave Hansen            2015-09-04  507  		return 0;
71d734103edfa2 Mel Gorman             2020-07-08  508  
9b93f33105f5f9 Amir Goldstein         2020-07-16  509  	marks_mask = sb->s_fsnotify_mask;
71d734103edfa2 Mel Gorman             2020-07-08  510  	if (mnt)
71d734103edfa2 Mel Gorman             2020-07-08  511  		marks_mask |= mnt->mnt_fsnotify_mask;
9b93f33105f5f9 Amir Goldstein         2020-07-16  512  	if (inode)
                                                            ^^^^^^

9b93f33105f5f9 Amir Goldstein         2020-07-16  513  		marks_mask |= inode->i_fsnotify_mask;
fecc4559780d52 Amir Goldstein         2020-12-02  514  	if (parent)
fecc4559780d52 Amir Goldstein         2020-12-02  515  		marks_mask |= parent->i_fsnotify_mask;
497b0c5a7c0688 Amir Goldstein         2020-07-16  516  
71d734103edfa2 Mel Gorman             2020-07-08  517  
613a807fe7c793 Eric Paris             2010-07-28  518  	/*
613a807fe7c793 Eric Paris             2010-07-28  519  	 * if this is a modify event we may need to clear the ignored masks
497b0c5a7c0688 Amir Goldstein         2020-07-16  520  	 * otherwise return if none of the marks care about this type of event.
613a807fe7c793 Eric Paris             2010-07-28  521  	 */
71d734103edfa2 Mel Gorman             2020-07-08  522  	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
71d734103edfa2 Mel Gorman             2020-07-08  523  	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
613a807fe7c793 Eric Paris             2010-07-28  524  		return 0;
75c1be487a690d Eric Paris             2010-07-28  525  
9385a84d7e1f65 Jan Kara               2016-11-10  526  	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
75c1be487a690d Eric Paris             2010-07-28  527  
45a9fb3725d886 Amir Goldstein         2019-01-10  528  	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
45a9fb3725d886 Amir Goldstein         2019-01-10  529  		fsnotify_first_mark(&sb->s_fsnotify_marks);
9bdda4e9cf2dce Amir Goldstein         2018-09-01  530  	if (mnt) {
47d9c7cc457adc Amir Goldstein         2018-04-20  531  		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
3427ce71554123 Miklos Szeredi         2017-10-30  532  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
7131485a93679f Eric Paris             2009-12-17  533  	}
9b93f33105f5f9 Amir Goldstein         2020-07-16  534  	if (inode) {
                                                            ^^^^^
Lots of checking...  Maybe this is really NULL?

9b93f33105f5f9 Amir Goldstein         2020-07-16  535  		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
9b93f33105f5f9 Amir Goldstein         2020-07-16  536  			fsnotify_first_mark(&inode->i_fsnotify_marks);
9b93f33105f5f9 Amir Goldstein         2020-07-16  537  	}
fecc4559780d52 Amir Goldstein         2020-12-02  538  	if (parent) {
fecc4559780d52 Amir Goldstein         2020-12-02  539  		iter_info.marks[FSNOTIFY_OBJ_TYPE_PARENT] =
fecc4559780d52 Amir Goldstein         2020-12-02  540  			fsnotify_first_mark(&parent->i_fsnotify_marks);
497b0c5a7c0688 Amir Goldstein         2020-07-16  541  	}
75c1be487a690d Eric Paris             2010-07-28  542  
8edc6e1688fc8f Jan Kara               2014-11-13  543  	/*
60f7ed8c7c4d06 Amir Goldstein         2018-09-01  544  	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
60f7ed8c7c4d06 Amir Goldstein         2018-09-01  545  	 * ignore masks are properly reflected for mount/sb mark notifications.
8edc6e1688fc8f Jan Kara               2014-11-13  546  	 * That's why this traversal is so complicated...
8edc6e1688fc8f Jan Kara               2014-11-13  547  	 */
d9a6f30bb89309 Amir Goldstein         2018-04-20  548  	while (fsnotify_iter_select_report_types(&iter_info)) {
dca640915c7b84 Amir Goldstein         2021-06-29  549  		ret = send_to_group(mask, event_info, &iter_info);
613a807fe7c793 Eric Paris             2010-07-28  550  
ff8bcbd03da881 Eric Paris             2010-10-28  551  		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
ff8bcbd03da881 Eric Paris             2010-10-28  552  			goto out;
ff8bcbd03da881 Eric Paris             2010-10-28  553  
d9a6f30bb89309 Amir Goldstein         2018-04-20  554  		fsnotify_iter_next(&iter_info);
90586523eb4b34 Eric Paris             2009-05-21  555  	}
ff8bcbd03da881 Eric Paris             2010-10-28  556  	ret = 0;
ff8bcbd03da881 Eric Paris             2010-10-28  557  out:
9385a84d7e1f65 Jan Kara               2016-11-10  558  	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
c4ec54b40d33f8 Eric Paris             2009-12-17  559  
98b5c10d320adf Jean-Christophe Dubois 2010-03-23  560  	return ret;
90586523eb4b34 Eric Paris             2009-05-21  561  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

