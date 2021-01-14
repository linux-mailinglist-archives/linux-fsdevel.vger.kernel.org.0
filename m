Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD072F616A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 14:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbhANNAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 08:00:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:17778 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbhANNAH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:00:07 -0500
IronPort-SDR: mBX1eJ/+bMvnlTlMmLvsLYA7j9SxS1j9+vbMdnHqWmpYFa6g/Lf8iRZxC/g4By4OGPDSK8H9y7
 L6sghgY1u1Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="174851265"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="gz'50?scan'50,208,50";a="174851265"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 04:59:25 -0800
IronPort-SDR: nVHMFVmxpCr/KzFlgKAmKUF3y18z6tT82IkzP0nfCvWkrbmPlygqZLSo0Cq+ezDj0qVdl6tENF
 41m9LuQdlmYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="gz'50?scan'50,208,50";a="572317833"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2021 04:59:22 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l02Di-0000qT-A6; Thu, 14 Jan 2021 12:59:22 +0000
Date:   Thu, 14 Jan 2021 20:58:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 resend] dcookies: Make dcookies depend on
 CONFIG_OPROFILE
Message-ID: <202101142046.bTQxxONr-lkp@intel.com>
References: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Viresh,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.11-rc3 next-20210114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Viresh-Kumar/dcookies-Make-dcookies-depend-on-CONFIG_OPROFILE/20210111-140734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7c53f6b671f4aba70ff15e1b05148b10d58c2837
config: x86_64-rhel (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/d48f031313d175610c430e9f04c3b6974e3fd3e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Viresh-Kumar/dcookies-Make-dcookies-depend-on-CONFIG_OPROFILE/20210111-140734
        git checkout d48f031313d175610c430e9f04c3b6974e3fd3e2
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/dcookies.c:117:5: error: redefinition of 'get_dcookie'
     117 | int get_dcookie(const struct path *path, unsigned long *cookie)
         |     ^~~~~~~~~~~
   In file included from fs/dcookies.c:26:
   include/linux/dcookies.h:62:19: note: previous definition of 'get_dcookie' was here
      62 | static inline int get_dcookie(const struct path *path, unsigned long *cookie)
         |                   ^~~~~~~~~~~
>> fs/dcookies.c:316:23: error: redefinition of 'dcookie_register'
     316 | struct dcookie_user * dcookie_register(void)
         |                       ^~~~~~~~~~~~~~~~
   In file included from fs/dcookies.c:26:
   include/linux/dcookies.h:52:37: note: previous definition of 'dcookie_register' was here
      52 | static inline struct dcookie_user * dcookie_register(void)
         |                                     ^~~~~~~~~~~~~~~~
>> fs/dcookies.c:341:6: error: redefinition of 'dcookie_unregister'
     341 | void dcookie_unregister(struct dcookie_user * user)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from fs/dcookies.c:26:
   include/linux/dcookies.h:57:20: note: previous definition of 'dcookie_unregister' was here
      57 | static inline void dcookie_unregister(struct dcookie_user * user)
         |                    ^~~~~~~~~~~~~~~~~~


vim +/get_dcookie +117 fs/dcookies.c

^1da177e4c3f4152 Linus Torvalds    2005-04-16  112  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  113  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  114  /* This is the main kernel-side routine that retrieves the cookie
^1da177e4c3f4152 Linus Torvalds    2005-04-16  115   * value for a dentry/vfsmnt pair.
^1da177e4c3f4152 Linus Torvalds    2005-04-16  116   */
71215a75ceddf38b Al Viro           2016-11-20 @117  int get_dcookie(const struct path *path, unsigned long *cookie)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  118  {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  119  	int err = 0;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  120  	struct dcookie_struct * dcs;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  121  
353ab6e97b8f209d Ingo Molnar       2006-03-26  122  	mutex_lock(&dcookie_mutex);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  123  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  124  	if (!is_live()) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  125  		err = -EINVAL;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  126  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  127  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  128  
c2452f32786159ed Nick Piggin       2008-12-01  129  	if (path->dentry->d_flags & DCACHE_COOKIE) {
c2452f32786159ed Nick Piggin       2008-12-01  130  		dcs = find_dcookie((unsigned long)path->dentry);
c2452f32786159ed Nick Piggin       2008-12-01  131  	} else {
448678a0f3cdd015 Jan Blunck        2008-02-14  132  		dcs = alloc_dcookie(path);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  133  		if (!dcs) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  134  			err = -ENOMEM;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  135  			goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  136  		}
c2452f32786159ed Nick Piggin       2008-12-01  137  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  138  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  139  	*cookie = dcookie_value(dcs);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  140  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  141  out:
353ab6e97b8f209d Ingo Molnar       2006-03-26  142  	mutex_unlock(&dcookie_mutex);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  143  	return err;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  144  }
^1da177e4c3f4152 Linus Torvalds    2005-04-16  145  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  146  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  147  /* And here is where the userspace process can look up the cookie value
^1da177e4c3f4152 Linus Torvalds    2005-04-16  148   * to retrieve the path.
^1da177e4c3f4152 Linus Torvalds    2005-04-16  149   */
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  150  static int do_lookup_dcookie(u64 cookie64, char __user *buf, size_t len)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  151  {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  152  	unsigned long cookie = (unsigned long)cookie64;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  153  	int err = -EINVAL;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  154  	char * kbuf;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  155  	char * path;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  156  	size_t pathlen;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  157  	struct dcookie_struct * dcs;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  158  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  159  	/* we could leak path information to users
^1da177e4c3f4152 Linus Torvalds    2005-04-16  160  	 * without dir read permission without this
^1da177e4c3f4152 Linus Torvalds    2005-04-16  161  	 */
^1da177e4c3f4152 Linus Torvalds    2005-04-16  162  	if (!capable(CAP_SYS_ADMIN))
^1da177e4c3f4152 Linus Torvalds    2005-04-16  163  		return -EPERM;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  164  
353ab6e97b8f209d Ingo Molnar       2006-03-26  165  	mutex_lock(&dcookie_mutex);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  166  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  167  	if (!is_live()) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  168  		err = -EINVAL;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  169  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  170  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  171  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  172  	if (!(dcs = find_dcookie(cookie)))
^1da177e4c3f4152 Linus Torvalds    2005-04-16  173  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  174  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  175  	err = -ENOMEM;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  176  	kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  177  	if (!kbuf)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  178  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  179  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  180  	/* FIXME: (deleted) ? */
cf28b4863f9ee8f1 Jan Blunck        2008-02-14  181  	path = d_path(&dcs->path, kbuf, PAGE_SIZE);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  182  
fe47ae7f53e179d2 Robert Richter    2011-05-31  183  	mutex_unlock(&dcookie_mutex);
fe47ae7f53e179d2 Robert Richter    2011-05-31  184  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  185  	if (IS_ERR(path)) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  186  		err = PTR_ERR(path);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  187  		goto out_free;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  188  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  189  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  190  	err = -ERANGE;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  191   
^1da177e4c3f4152 Linus Torvalds    2005-04-16  192  	pathlen = kbuf + PAGE_SIZE - path;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  193  	if (pathlen <= len) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  194  		err = pathlen;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  195  		if (copy_to_user(buf, path, pathlen))
^1da177e4c3f4152 Linus Torvalds    2005-04-16  196  			err = -EFAULT;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  197  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  198  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  199  out_free:
^1da177e4c3f4152 Linus Torvalds    2005-04-16  200  	kfree(kbuf);
fe47ae7f53e179d2 Robert Richter    2011-05-31  201  	return err;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  202  out:
353ab6e97b8f209d Ingo Molnar       2006-03-26  203  	mutex_unlock(&dcookie_mutex);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  204  	return err;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  205  }
^1da177e4c3f4152 Linus Torvalds    2005-04-16  206  
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  207  SYSCALL_DEFINE3(lookup_dcookie, u64, cookie64, char __user *, buf, size_t, len)
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  208  {
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  209  	return do_lookup_dcookie(cookie64, buf, len);
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  210  }
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  211  
d5dc77bfeeab0b03 Al Viro           2013-02-25  212  #ifdef CONFIG_COMPAT
d8d14bd09cddbaf0 Heiko Carstens    2014-01-29  213  COMPAT_SYSCALL_DEFINE4(lookup_dcookie, u32, w0, u32, w1, char __user *, buf, compat_size_t, len)
d5dc77bfeeab0b03 Al Viro           2013-02-25  214  {
d5dc77bfeeab0b03 Al Viro           2013-02-25  215  #ifdef __BIG_ENDIAN
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  216  	return do_lookup_dcookie(((u64)w0 << 32) | w1, buf, len);
d5dc77bfeeab0b03 Al Viro           2013-02-25  217  #else
98e5f7bd2c67f402 Dominik Brodowski 2018-03-17  218  	return do_lookup_dcookie(((u64)w1 << 32) | w0, buf, len);
d5dc77bfeeab0b03 Al Viro           2013-02-25  219  #endif
d5dc77bfeeab0b03 Al Viro           2013-02-25  220  }
d5dc77bfeeab0b03 Al Viro           2013-02-25  221  #endif
d5dc77bfeeab0b03 Al Viro           2013-02-25  222  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  223  static int dcookie_init(void)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  224  {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  225  	struct list_head * d;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  226  	unsigned int i, hash_bits;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  227  	int err = -ENOMEM;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  228  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  229  	dcookie_cache = kmem_cache_create("dcookie_cache",
^1da177e4c3f4152 Linus Torvalds    2005-04-16  230  		sizeof(struct dcookie_struct),
20c2df83d25c6a95 Paul Mundt        2007-07-20  231  		0, 0, NULL);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  232  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  233  	if (!dcookie_cache)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  234  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  235  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  236  	dcookie_hashtable = kmalloc(PAGE_SIZE, GFP_KERNEL);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  237  	if (!dcookie_hashtable)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  238  		goto out_kmem;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  239  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  240  	err = 0;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  241  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  242  	/*
^1da177e4c3f4152 Linus Torvalds    2005-04-16  243  	 * Find the power-of-two list-heads that can fit into the allocation..
^1da177e4c3f4152 Linus Torvalds    2005-04-16  244  	 * We don't guarantee that "sizeof(struct list_head)" is necessarily
^1da177e4c3f4152 Linus Torvalds    2005-04-16  245  	 * a power-of-two.
^1da177e4c3f4152 Linus Torvalds    2005-04-16  246  	 */
^1da177e4c3f4152 Linus Torvalds    2005-04-16  247  	hash_size = PAGE_SIZE / sizeof(struct list_head);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  248  	hash_bits = 0;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  249  	do {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  250  		hash_bits++;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  251  	} while ((hash_size >> hash_bits) != 0);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  252  	hash_bits--;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  253  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  254  	/*
^1da177e4c3f4152 Linus Torvalds    2005-04-16  255  	 * Re-calculate the actual number of entries and the mask
^1da177e4c3f4152 Linus Torvalds    2005-04-16  256  	 * from the number of bits we can fit.
^1da177e4c3f4152 Linus Torvalds    2005-04-16  257  	 */
^1da177e4c3f4152 Linus Torvalds    2005-04-16  258  	hash_size = 1UL << hash_bits;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  259  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  260  	/* And initialize the newly allocated array */
^1da177e4c3f4152 Linus Torvalds    2005-04-16  261  	d = dcookie_hashtable;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  262  	i = hash_size;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  263  	do {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  264  		INIT_LIST_HEAD(d);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  265  		d++;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  266  		i--;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  267  	} while (i);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  268  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  269  out:
^1da177e4c3f4152 Linus Torvalds    2005-04-16  270  	return err;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  271  out_kmem:
^1da177e4c3f4152 Linus Torvalds    2005-04-16  272  	kmem_cache_destroy(dcookie_cache);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  273  	goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  274  }
^1da177e4c3f4152 Linus Torvalds    2005-04-16  275  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  276  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  277  static void free_dcookie(struct dcookie_struct * dcs)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  278  {
c2452f32786159ed Nick Piggin       2008-12-01  279  	struct dentry *d = dcs->path.dentry;
c2452f32786159ed Nick Piggin       2008-12-01  280  
c2452f32786159ed Nick Piggin       2008-12-01  281  	spin_lock(&d->d_lock);
c2452f32786159ed Nick Piggin       2008-12-01  282  	d->d_flags &= ~DCACHE_COOKIE;
c2452f32786159ed Nick Piggin       2008-12-01  283  	spin_unlock(&d->d_lock);
c2452f32786159ed Nick Piggin       2008-12-01  284  
448678a0f3cdd015 Jan Blunck        2008-02-14  285  	path_put(&dcs->path);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  286  	kmem_cache_free(dcookie_cache, dcs);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  287  }
^1da177e4c3f4152 Linus Torvalds    2005-04-16  288  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  289  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  290  static void dcookie_exit(void)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  291  {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  292  	struct list_head * list;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  293  	struct list_head * pos;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  294  	struct list_head * pos2;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  295  	struct dcookie_struct * dcs;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  296  	size_t i;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  297  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  298  	for (i = 0; i < hash_size; ++i) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  299  		list = dcookie_hashtable + i;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  300  		list_for_each_safe(pos, pos2, list) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  301  			dcs = list_entry(pos, struct dcookie_struct, hash_list);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  302  			list_del(&dcs->hash_list);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  303  			free_dcookie(dcs);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  304  		}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  305  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  306  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  307  	kfree(dcookie_hashtable);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  308  	kmem_cache_destroy(dcookie_cache);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  309  }
^1da177e4c3f4152 Linus Torvalds    2005-04-16  310  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  311  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  312  struct dcookie_user {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  313  	struct list_head next;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  314  };
^1da177e4c3f4152 Linus Torvalds    2005-04-16  315   
^1da177e4c3f4152 Linus Torvalds    2005-04-16 @316  struct dcookie_user * dcookie_register(void)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  317  {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  318  	struct dcookie_user * user;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  319  
353ab6e97b8f209d Ingo Molnar       2006-03-26  320  	mutex_lock(&dcookie_mutex);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  321  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  322  	user = kmalloc(sizeof(struct dcookie_user), GFP_KERNEL);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  323  	if (!user)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  324  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  325  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  326  	if (!is_live() && dcookie_init())
^1da177e4c3f4152 Linus Torvalds    2005-04-16  327  		goto out_free;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  328  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  329  	list_add(&user->next, &dcookie_users);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  330  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  331  out:
353ab6e97b8f209d Ingo Molnar       2006-03-26  332  	mutex_unlock(&dcookie_mutex);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  333  	return user;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  334  out_free:
^1da177e4c3f4152 Linus Torvalds    2005-04-16  335  	kfree(user);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  336  	user = NULL;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  337  	goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  338  }
^1da177e4c3f4152 Linus Torvalds    2005-04-16  339  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
t8BCluqkYOWnUWHJydIl3Oz+H1SpLLOK7AIA

--IS0zKkzwUGydFO0o--
