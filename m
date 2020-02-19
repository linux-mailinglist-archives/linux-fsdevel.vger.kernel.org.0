Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1616428F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 11:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSKud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 05:50:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:61771 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSKud (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:50:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 02:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="gz'50?scan'50,208,50";a="258882657"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2020 02:50:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4Mw0-0009f2-QS; Wed, 19 Feb 2020 18:50:28 +0800
Date:   Wed, 19 Feb 2020 18:50:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] fsnotify: simplify arguments passing to
 fsnotify_parent()
Message-ID: <202002191836.KJ7wwO0T%lkp@intel.com>
References: <20200217131455.31107-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20200217131455.31107-6-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Amir,

I love your patch! Yet something to improve:

[auto build test ERROR on 11a48a5a18c63fd7621bb050228cebf13566e4d8]

url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/Fanotify-event-with-name-info/20200219-160517
base:    11a48a5a18c63fd7621bb050228cebf13566e4d8
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from fs///attr.c:15:0:
   include/linux/fsnotify.h: In function 'fsnotify_dentry':
>> include/linux/fsnotify.h:52:18: warning: passing argument 1 of 'fsnotify_parent' makes integer from pointer without a cast [-Wint-conversion]
     fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
                     ^~~~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: expected '__u32 {aka unsigned int}' but argument is of type 'struct dentry *'
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
>> include/linux/fsnotify.h:52:26: warning: passing argument 2 of 'fsnotify_parent' makes pointer from integer without a cast [-Wint-conversion]
     fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
                             ^~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: expected 'const void *' but argument is of type '__u32 {aka unsigned int}'
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
   include/linux/fsnotify.h:52:32: warning: passing argument 3 of 'fsnotify_parent' makes integer from pointer without a cast [-Wint-conversion]
     fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
                                   ^~~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: expected 'int' but argument is of type 'struct inode *'
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
>> include/linux/fsnotify.h:52:2: error: too many arguments to function 'fsnotify_parent'
     fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
     ^~~~~~~~~~~~~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: declared here
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
   include/linux/fsnotify.h: In function 'fsnotify_file':
   include/linux/fsnotify.h:68:24: warning: passing argument 1 of 'fsnotify_parent' makes integer from pointer without a cast [-Wint-conversion]
     ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
                           ^~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: expected '__u32 {aka unsigned int}' but argument is of type 'struct dentry * const'
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
   include/linux/fsnotify.h:68:38: warning: passing argument 2 of 'fsnotify_parent' makes pointer from integer without a cast [-Wint-conversion]
     ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
                                         ^~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: expected 'const void *' but argument is of type '__u32 {aka unsigned int}'
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
   include/linux/fsnotify.h:68:44: warning: passing argument 3 of 'fsnotify_parent' makes integer from pointer without a cast [-Wint-conversion]
     ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
                                               ^~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: expected 'int' but argument is of type 'const struct path *'
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~
   In file included from fs///attr.c:15:0:
   include/linux/fsnotify.h:68:8: error: too many arguments to function 'fsnotify_parent'
     ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
           ^~~~~~~~~~~~~~~
   In file included from include/linux/fsnotify.h:15:0,
                    from fs///attr.c:15:
   include/linux/fsnotify_backend.h:543:19: note: declared here
    static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
                      ^~~~~~~~~~~~~~~

vim +/fsnotify_parent +52 include/linux/fsnotify.h

    40	
    41	/*
    42	 * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
    43	 * an event is on a file/dentry.
    44	 */
    45	static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
    46	{
    47		struct inode *inode = d_inode(dentry);
    48	
    49		if (S_ISDIR(inode->i_mode))
    50			mask |= FS_ISDIR;
    51	
  > 52		fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
    53		fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
    54	}
    55	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FL5UXtIhxfXey3p5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--FL5UXtIhxfXey3p5--
