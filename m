Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4C3B7ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 02:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhF3AOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 20:14:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:16486 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhF3AOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 20:14:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="206441408"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="gz'50?scan'50,208,50";a="206441408"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 17:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="gz'50?scan'50,208,50";a="625824367"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2021 17:11:36 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyNpI-0009RM-6Z; Wed, 30 Jun 2021 00:11:36 +0000
Date:   Wed, 30 Jun 2021 08:10:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, amir73il@gmail.com
Cc:     kbuild-all@lists.01.org, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in
 struct fsnotify_event_info
Message-ID: <202106300851.YueoePZh-lkp@intel.com>
References: <20210629191035.681913-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-8-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gabriel,

I love your patch! Yet something to improve:

[auto build test ERROR on ext3/fsnotify]
[also build test ERROR on ext4/dev linus/master v5.13 next-20210629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/dca640915c7b840656b052e138effd501bd5d5e1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
        git checkout dca640915c7b840656b052e138effd501bd5d5e1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/kernfs/file.c:16:
   include/linux/fsnotify.h: In function 'fsnotify_name':
   include/linux/fsnotify.h:33:2: error: implicit declaration of function '__fsnotify'; did you mean 'fsnotify'? [-Werror=implicit-function-declaration]
      33 |  __fsnotify(mask, &(struct fsnotify_event_info) {
         |  ^~~~~~~~~~
         |  fsnotify
   fs/kernfs/file.c: In function 'kernfs_notify_workfn':
>> fs/kernfs/file.c:887:7: error: passing argument 2 of 'fsnotify' from incompatible pointer type [-Werror=incompatible-pointer-types]
     887 |       inode, FSNOTIFY_EVENT_INODE,
         |       ^~~~~
         |       |
         |       struct inode *
   In file included from include/linux/fsnotify.h:15,
                    from fs/kernfs/file.c:16:
   include/linux/fsnotify_backend.h:636:41: note: expected 'const struct fsnotify_event_info *' but argument is of type 'struct inode *'
     636 |       const struct fsnotify_event_info *event_info)
         |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
>> fs/kernfs/file.c:886:5: error: too many arguments to function 'fsnotify'
     886 |     fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
         |     ^~~~~~~~
   In file included from include/linux/fsnotify.h:15,
                    from fs/kernfs/file.c:16:
   include/linux/fsnotify_backend.h:635:19: note: declared here
     635 | static inline int fsnotify(__u32 mask,
         |                   ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/fsnotify +887 fs/kernfs/file.c

414985ae23c031 Tejun Heo      2013-11-28  845  
ecca47ce829484 Tejun Heo      2014-07-01  846  static void kernfs_notify_workfn(struct work_struct *work)
414985ae23c031 Tejun Heo      2013-11-28  847  {
ecca47ce829484 Tejun Heo      2014-07-01  848  	struct kernfs_node *kn;
d911d98748018f Tejun Heo      2014-04-09  849  	struct kernfs_super_info *info;
ecca47ce829484 Tejun Heo      2014-07-01  850  repeat:
ecca47ce829484 Tejun Heo      2014-07-01  851  	/* pop one off the notify_list */
ecca47ce829484 Tejun Heo      2014-07-01  852  	spin_lock_irq(&kernfs_notify_lock);
ecca47ce829484 Tejun Heo      2014-07-01  853  	kn = kernfs_notify_list;
ecca47ce829484 Tejun Heo      2014-07-01  854  	if (kn == KERNFS_NOTIFY_EOL) {
ecca47ce829484 Tejun Heo      2014-07-01  855  		spin_unlock_irq(&kernfs_notify_lock);
d911d98748018f Tejun Heo      2014-04-09  856  		return;
ecca47ce829484 Tejun Heo      2014-07-01  857  	}
ecca47ce829484 Tejun Heo      2014-07-01  858  	kernfs_notify_list = kn->attr.notify_next;
ecca47ce829484 Tejun Heo      2014-07-01  859  	kn->attr.notify_next = NULL;
ecca47ce829484 Tejun Heo      2014-07-01  860  	spin_unlock_irq(&kernfs_notify_lock);
d911d98748018f Tejun Heo      2014-04-09  861  
d911d98748018f Tejun Heo      2014-04-09  862  	/* kick fsnotify */
d911d98748018f Tejun Heo      2014-04-09  863  	mutex_lock(&kernfs_mutex);
d911d98748018f Tejun Heo      2014-04-09  864  
ecca47ce829484 Tejun Heo      2014-07-01  865  	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
df6a58c5c5aa8e Tejun Heo      2016-06-17  866  		struct kernfs_node *parent;
497b0c5a7c0688 Amir Goldstein 2020-07-16  867  		struct inode *p_inode = NULL;
d911d98748018f Tejun Heo      2014-04-09  868  		struct inode *inode;
25b229dff4ffff Al Viro        2019-04-26  869  		struct qstr name;
d911d98748018f Tejun Heo      2014-04-09  870  
df6a58c5c5aa8e Tejun Heo      2016-06-17  871  		/*
df6a58c5c5aa8e Tejun Heo      2016-06-17  872  		 * We want fsnotify_modify() on @kn but as the
df6a58c5c5aa8e Tejun Heo      2016-06-17  873  		 * modifications aren't originating from userland don't
df6a58c5c5aa8e Tejun Heo      2016-06-17  874  		 * have the matching @file available.  Look up the inodes
df6a58c5c5aa8e Tejun Heo      2016-06-17  875  		 * and generate the events manually.
df6a58c5c5aa8e Tejun Heo      2016-06-17  876  		 */
67c0496e87d193 Tejun Heo      2019-11-04  877  		inode = ilookup(info->sb, kernfs_ino(kn));
d911d98748018f Tejun Heo      2014-04-09  878  		if (!inode)
d911d98748018f Tejun Heo      2014-04-09  879  			continue;
d911d98748018f Tejun Heo      2014-04-09  880  
25b229dff4ffff Al Viro        2019-04-26  881  		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
df6a58c5c5aa8e Tejun Heo      2016-06-17  882  		parent = kernfs_get_parent(kn);
df6a58c5c5aa8e Tejun Heo      2016-06-17  883  		if (parent) {
67c0496e87d193 Tejun Heo      2019-11-04  884  			p_inode = ilookup(info->sb, kernfs_ino(parent));
df6a58c5c5aa8e Tejun Heo      2016-06-17  885  			if (p_inode) {
40a100d3adc1ad Amir Goldstein 2020-07-22 @886  				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
40a100d3adc1ad Amir Goldstein 2020-07-22 @887  					 inode, FSNOTIFY_EVENT_INODE,
40a100d3adc1ad Amir Goldstein 2020-07-22  888  					 p_inode, &name, inode, 0);
df6a58c5c5aa8e Tejun Heo      2016-06-17  889  				iput(p_inode);
d911d98748018f Tejun Heo      2014-04-09  890  			}
d911d98748018f Tejun Heo      2014-04-09  891  
df6a58c5c5aa8e Tejun Heo      2016-06-17  892  			kernfs_put(parent);
df6a58c5c5aa8e Tejun Heo      2016-06-17  893  		}
df6a58c5c5aa8e Tejun Heo      2016-06-17  894  
82ace1efb3cb1d Amir Goldstein 2020-07-22  895  		if (!p_inode)
82ace1efb3cb1d Amir Goldstein 2020-07-22  896  			fsnotify_inode(inode, FS_MODIFY);
497b0c5a7c0688 Amir Goldstein 2020-07-16  897  
d911d98748018f Tejun Heo      2014-04-09  898  		iput(inode);
d911d98748018f Tejun Heo      2014-04-09  899  	}
d911d98748018f Tejun Heo      2014-04-09  900  
d911d98748018f Tejun Heo      2014-04-09  901  	mutex_unlock(&kernfs_mutex);
ecca47ce829484 Tejun Heo      2014-07-01  902  	kernfs_put(kn);
ecca47ce829484 Tejun Heo      2014-07-01  903  	goto repeat;
ecca47ce829484 Tejun Heo      2014-07-01  904  }
ecca47ce829484 Tejun Heo      2014-07-01  905  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AdKjN4YJmgAA

--+HP7ph2BbKc20aGI--
