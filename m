Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201430FD75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbhBDT47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 14:56:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:2429 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239754AbhBDT4K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:56:10 -0500
IronPort-SDR: kzn4k7IdKsGnACeoRAtA1aiAOCM7P8bLm72jH7azt1dGFCC/xONIR4mYpi1OhsSegsPLO/qIvj
 i6i0hD3JreMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177813926"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="gz'50?scan'50,208,50";a="177813926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 11:55:52 -0800
IronPort-SDR: S25vqe7yT5oYqV6udJTQWpk6T6M5DX9WRMdavHiX+CzdYtp6fad+hCtr+cBgUylLTPOgCLfdNi
 IDJHqYuIAG9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="gz'50?scan'50,208,50";a="415491970"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2021 11:55:47 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7kjC-00019I-OL; Thu, 04 Feb 2021 19:55:46 +0000
Date:   Fri, 5 Feb 2021 03:55:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>, sprabhu@redhat.com
Cc:     kbuild-all@lists.01.org, dhowells@redhat.com,
        Jarkko Sakkinen <jarkko@kernel.org>, christian@brauner.io,
        selinux@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] keys: Allow request_key upcalls from a container to
 be intercepted
Message-ID: <202102050336.9zFaNQb3-lkp@intel.com>
References: <161246086770.1990927.4967525549888707001.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <161246086770.1990927.4967525549888707001.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on cgroup/for-next]
[also build test WARNING on dhowells-fs/fscache-next linus/master v5.11-rc6]
[cannot apply to security/next-testing tip/timers/core next-20210125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Howells/keys-request_key-interception-in-containers/20210205-015946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
config: powerpc64-randconfig-s031-20210204 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-215-g0fb77bb6-dirty
        # https://github.com/0day-ci/linux/commit/6d049eb50238910e375143259391790a8b69ebc6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Howells/keys-request_key-interception-in-containers/20210205-015946
        git checkout 6d049eb50238910e375143259391790a8b69ebc6
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> security/keys/service.c:101:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *type @@     got char const [noderef] __user *type_name @@
   security/keys/service.c:101:40: sparse:     expected char const *type
   security/keys/service.c:101:40: sparse:     got char const [noderef] __user *type_name
>> security/keys/service.c:177:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> security/keys/service.c:177:9: sparse:    struct hlist_node [noderef] __rcu *
>> security/keys/service.c:177:9: sparse:    struct hlist_node *

vim +101 security/keys/service.c

    61	
    62	/*
    63	 * Allocate a service record.
    64	 */
    65	static struct request_key_service *alloc_key_service(key_serial_t queue_keyring,
    66							     const char __user *type_name,
    67							     unsigned int ns_mask)
    68	{
    69		struct request_key_service *svc;
    70		struct key_type *type;
    71		key_ref_t key_ref;
    72		int ret;
    73		u8 selectivity = 0;
    74	
    75		svc = kzalloc(sizeof(struct request_key_service), GFP_KERNEL);
    76		if (!svc)
    77			return ERR_PTR(-ENOMEM);
    78	
    79		if (queue_keyring != 0) {
    80			key_ref = lookup_user_key(queue_keyring, 0, KEY_NEED_SEARCH);
    81			if (IS_ERR(key_ref)) {
    82				ret = PTR_ERR(key_ref);
    83				goto err_svc;
    84			}
    85	
    86			svc->queue_keyring = key_ref_to_ptr(key_ref);
    87		}
    88	
    89		/* Save the matching criteria.  Anything the caller doesn't care about
    90		 * we leave as NULL.
    91		 */
    92		if (type_name) {
    93			ret = strncpy_from_user(svc->type, type_name, sizeof(svc->type));
    94			if (ret < 0)
    95				goto err_keyring;
    96			if (ret >= sizeof(svc->type)) {
    97				ret = -EINVAL;
    98				goto err_keyring;
    99			}
   100	
 > 101			type = key_type_lookup(type_name);
   102			if (IS_ERR(type)) {
   103				ret = -EINVAL;
   104				goto err_keyring;
   105			}
   106			memcpy(svc->type, type->name, sizeof(svc->type));
   107			key_type_put(type);
   108		}
   109	
   110		if (ns_mask & KEY_SERVICE_NS_UTS) {
   111			svc->uts_ns = get_ns_tag(current->nsproxy->uts_ns->ns.tag);
   112			selectivity++;
   113		}
   114		if (ns_mask & KEY_SERVICE_NS_IPC) {
   115			svc->ipc_ns = get_ns_tag(current->nsproxy->ipc_ns->ns.tag);
   116			selectivity++;
   117		}
   118		if (ns_mask & KEY_SERVICE_NS_MNT) {
   119			svc->mnt_ns = get_ns_tag(current->nsproxy->mnt_ns->ns.tag);
   120			selectivity++;
   121		}
   122		if (ns_mask & KEY_SERVICE_NS_PID) {
   123			svc->pid_ns = get_ns_tag(task_active_pid_ns(current)->ns.tag);
   124			selectivity++;
   125		}
   126		if (ns_mask & KEY_SERVICE_NS_NET) {
   127			svc->net_ns = get_ns_tag(current->nsproxy->net_ns->ns.tag);
   128			selectivity++;
   129		}
   130		if (ns_mask & KEY_SERVICE_NS_CGROUP) {
   131			svc->cgroup_ns = get_ns_tag(current->nsproxy->cgroup_ns->ns.tag);
   132			selectivity++;
   133		}
   134	
   135		svc->selectivity = selectivity;
   136		return svc;
   137	
   138	err_keyring:
   139		key_put(svc->queue_keyring);
   140	err_svc:
   141		kfree(svc);
   142		return ERR_PTR(ret);
   143	}
   144	
   145	/*
   146	 * Install a request_key service into the user namespace's list
   147	 */
   148	static int install_key_service(struct user_namespace *user_ns,
   149				       struct request_key_service *svc)
   150	{
   151		struct request_key_service *p;
   152		struct hlist_node **pp;
   153		int ret = 0;
   154	
   155		spin_lock(&user_ns->request_key_services_lock);
   156	
   157		/* The services list is kept in order of selectivity.  The more exact
   158		 * matches a service requires, the earlier it is in the list.
   159		 */
   160		for (pp = &user_ns->request_key_services.first; *pp; pp = &(*pp)->next) {
   161			p = hlist_entry(*pp, struct request_key_service, user_ns_link);
   162			if (p->selectivity < svc->selectivity)
   163				goto insert_before;
   164			if (p->selectivity > svc->selectivity)
   165				continue;
   166			if (memcmp(p->type, svc->type, sizeof(p->type)) == 0 &&
   167			    p->uts_ns == svc->uts_ns &&
   168			    p->ipc_ns == svc->ipc_ns &&
   169			    p->mnt_ns == svc->mnt_ns &&
   170			    p->pid_ns == svc->pid_ns &&
   171			    p->net_ns == svc->net_ns &&
   172			    p->cgroup_ns == svc->cgroup_ns)
   173				goto duplicate;
   174		}
   175	
   176		svc->user_ns_link.pprev = pp;
 > 177		rcu_assign_pointer(*pp, &svc->user_ns_link);
   178		goto out;
   179	
   180	insert_before:
   181		hlist_add_before_rcu(&svc->user_ns_link, &p->user_ns_link);
   182		goto out;
   183	
   184	duplicate:
   185		free_key_service(svc);
   186		ret = -EEXIST;
   187	out:
   188		spin_unlock(&user_ns->request_key_services_lock);
   189		return ret;
   190	}
   191	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--
