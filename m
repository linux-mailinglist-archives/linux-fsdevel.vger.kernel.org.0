Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18FFF9C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfD3NSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 09:18:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:11199 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfD3NSo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:18:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 06:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="146996241"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Apr 2019 06:18:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hLSef-0004OS-8W; Tue, 30 Apr 2019 21:18:41 +0800
Date:   Tue, 30 Apr 2019 21:17:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
Message-ID: <201904302103.x1aEbTZu%lkp@intel.com>
References: <20190429222613.13345-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429222613.13345-1-mcroce@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matteo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]
[also build test WARNING on v5.1-rc7]
[cannot apply to next-20190429]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matteo-Croce/proc-sysctl-add-shared-variables-for-range-check/20190430-065026
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/parport/procfs.c:76:49: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct parport_device_info *info @@    got evice_info *info @@
>> drivers/parport/procfs.c:76:49: sparse:    expected struct parport_device_info *info
>> drivers/parport/procfs.c:76:49: sparse:    got void const *extra2
--
>> net/ipv4/devinet.c:2322:47: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct ipv4_devconf *cnf @@    got v4_devconf *cnf @@
>> net/ipv4/devinet.c:2322:47: sparse:    expected struct ipv4_devconf *cnf
>> net/ipv4/devinet.c:2322:47: sparse:    got void const *extra1
>> net/ipv4/devinet.c:2323:38: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
>> net/ipv4/devinet.c:2323:38: sparse:    expected struct net *net
>> net/ipv4/devinet.c:2323:38: sparse:    got void const *extra2
   net/ipv4/devinet.c:2376:38: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
   net/ipv4/devinet.c:2376:38: sparse:    expected struct net *net
   net/ipv4/devinet.c:2376:38: sparse:    got void const *extra2
   net/ipv4/devinet.c:2388:63: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct ipv4_devconf *cnf @@    got v4_devconf *cnf @@
   net/ipv4/devinet.c:2388:63: sparse:    expected struct ipv4_devconf *cnf
   net/ipv4/devinet.c:2388:63: sparse:    got void const *extra1
   net/ipv4/devinet.c:2417:30: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
   net/ipv4/devinet.c:2417:30: sparse:    expected struct net *net
   net/ipv4/devinet.c:2417:30: sparse:    got void const *extra2
--
>> net/ipv6/addrconf.c:6029:37: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct inet6_dev *idev @@    got  inet6_dev *idev @@
>> net/ipv6/addrconf.c:6029:37: sparse:    expected struct inet6_dev *idev
>> net/ipv6/addrconf.c:6029:37: sparse:    got void const *extra1
>> net/ipv6/addrconf.c:6136:38: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
>> net/ipv6/addrconf.c:6136:38: sparse:    expected struct net *net
>> net/ipv6/addrconf.c:6136:38: sparse:    got void const *extra2
   net/ipv6/addrconf.c:6152:53: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct inet6_dev *idev @@    got  inet6_dev *idev @@
   net/ipv6/addrconf.c:6152:53: sparse:    expected struct inet6_dev *idev
   net/ipv6/addrconf.c:6152:53: sparse:    got void const *extra1
   net/ipv6/addrconf.c:6235:30: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
   net/ipv6/addrconf.c:6235:30: sparse:    expected struct net *net
   net/ipv6/addrconf.c:6235:30: sparse:    got void const *extra2
   net/ipv6/addrconf.c:6282:45: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct inet6_dev *idev @@    got  inet6_dev *idev @@
   net/ipv6/addrconf.c:6282:45: sparse:    expected struct inet6_dev *idev
   net/ipv6/addrconf.c:6282:45: sparse:    got void const *extra1
--
>> net/ipv6/ndisc.c:1826:37: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net_device *dev @@    got net_device *dev @@
>> net/ipv6/ndisc.c:1826:37: sparse:    expected struct net_device *dev
>> net/ipv6/ndisc.c:1826:37: sparse:    got void const *extra1
--
>> net/decnet/dn_dev.c:252:39: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net_device *dev @@    got net_device *dev @@
>> net/decnet/dn_dev.c:252:39: sparse:    expected struct net_device *dev
>> net/decnet/dn_dev.c:252:39: sparse:    got void const *extra1
--
>> fs/fscache/main.c:61:46: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct workqueue_struct **wqp @@    got ue_struct **wqp @@
>> fs/fscache/main.c:61:46: sparse:    expected struct workqueue_struct **wqp
>> fs/fscache/main.c:61:46: sparse:    got void const *extra1
--
>> net/mpls/af_mpls.c:1370:44: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct mpls_dev *mdev @@    got t mpls_dev *mdev @@
>> net/mpls/af_mpls.c:1370:44: sparse:    expected struct mpls_dev *mdev
>> net/mpls/af_mpls.c:1370:44: sparse:    got void const *extra1
>> net/mpls/af_mpls.c:1372:38: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
>> net/mpls/af_mpls.c:1372:38: sparse:    expected struct net *net
>> net/mpls/af_mpls.c:1372:38: sparse:    got void const *extra2
--
>> net/netfilter/nf_log.c:422:32: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct net *net @@    got struct net *net @@
>> net/netfilter/nf_log.c:422:32: sparse:    expected struct net *net
>> net/netfilter/nf_log.c:422:32: sparse:    got void const *extra2
--
>> net/netfilter/ipvs/ip_vs_ctl.c:1664:40: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected struct netns_ipvs *ipvs @@    got netns_ipvs *ipvs @@
>> net/netfilter/ipvs/ip_vs_ctl.c:1664:40: sparse:    expected struct netns_ipvs *ipvs
>> net/netfilter/ipvs/ip_vs_ctl.c:1664:40: sparse:    got void const *extra2
   net/netfilter/ipvs/ip_vs_ctl.c:1298:27: sparse: sparse: dereference of noderef expression

vim +6029 net/ipv6/addrconf.c

^1da177e Linus Torvalds    2005-04-16  6024  
77751427 Marcelo Leitner   2015-02-23  6025  static
77751427 Marcelo Leitner   2015-02-23  6026  int addrconf_sysctl_mtu(struct ctl_table *ctl, int write,
77751427 Marcelo Leitner   2015-02-23  6027  			void __user *buffer, size_t *lenp, loff_t *ppos)
77751427 Marcelo Leitner   2015-02-23  6028  {
77751427 Marcelo Leitner   2015-02-23 @6029  	struct inet6_dev *idev = ctl->extra1;
77751427 Marcelo Leitner   2015-02-23  6030  	int min_mtu = IPV6_MIN_MTU;
77751427 Marcelo Leitner   2015-02-23  6031  	struct ctl_table lctl;
77751427 Marcelo Leitner   2015-02-23  6032  
77751427 Marcelo Leitner   2015-02-23  6033  	lctl = *ctl;
77751427 Marcelo Leitner   2015-02-23  6034  	lctl.extra1 = &min_mtu;
77751427 Marcelo Leitner   2015-02-23  6035  	lctl.extra2 = idev ? &idev->dev->mtu : NULL;
77751427 Marcelo Leitner   2015-02-23  6036  
77751427 Marcelo Leitner   2015-02-23  6037  	return proc_dointvec_minmax(&lctl, write, buffer, lenp, ppos);
77751427 Marcelo Leitner   2015-02-23  6038  }
77751427 Marcelo Leitner   2015-02-23  6039  
56d417b1 Brian Haley       2009-06-01  6040  static void dev_disable_change(struct inet6_dev *idev)
56d417b1 Brian Haley       2009-06-01  6041  {
75538c2b Cong Wang         2013-05-29  6042  	struct netdev_notifier_info info;
75538c2b Cong Wang         2013-05-29  6043  
56d417b1 Brian Haley       2009-06-01  6044  	if (!idev || !idev->dev)
56d417b1 Brian Haley       2009-06-01  6045  		return;
56d417b1 Brian Haley       2009-06-01  6046  
75538c2b Cong Wang         2013-05-29  6047  	netdev_notifier_info_init(&info, idev->dev);
56d417b1 Brian Haley       2009-06-01  6048  	if (idev->cnf.disable_ipv6)
75538c2b Cong Wang         2013-05-29  6049  		addrconf_notify(NULL, NETDEV_DOWN, &info);
56d417b1 Brian Haley       2009-06-01  6050  	else
75538c2b Cong Wang         2013-05-29  6051  		addrconf_notify(NULL, NETDEV_UP, &info);
56d417b1 Brian Haley       2009-06-01  6052  }
56d417b1 Brian Haley       2009-06-01  6053  
56d417b1 Brian Haley       2009-06-01  6054  static void addrconf_disable_change(struct net *net, __s32 newf)
56d417b1 Brian Haley       2009-06-01  6055  {
56d417b1 Brian Haley       2009-06-01  6056  	struct net_device *dev;
56d417b1 Brian Haley       2009-06-01  6057  	struct inet6_dev *idev;
56d417b1 Brian Haley       2009-06-01  6058  
03e4deff Kefeng Wang       2017-01-19  6059  	for_each_netdev(net, dev) {
56d417b1 Brian Haley       2009-06-01  6060  		idev = __in6_dev_get(dev);
56d417b1 Brian Haley       2009-06-01  6061  		if (idev) {
56d417b1 Brian Haley       2009-06-01  6062  			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
56d417b1 Brian Haley       2009-06-01  6063  			idev->cnf.disable_ipv6 = newf;
56d417b1 Brian Haley       2009-06-01  6064  			if (changed)
56d417b1 Brian Haley       2009-06-01  6065  				dev_disable_change(idev);
56d417b1 Brian Haley       2009-06-01  6066  		}
56d417b1 Brian Haley       2009-06-01  6067  	}
56d417b1 Brian Haley       2009-06-01  6068  }
56d417b1 Brian Haley       2009-06-01  6069  
013d97e9 Francesco Ruggeri 2012-01-16  6070  static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
56d417b1 Brian Haley       2009-06-01  6071  {
56d417b1 Brian Haley       2009-06-01  6072  	struct net *net;
013d97e9 Francesco Ruggeri 2012-01-16  6073  	int old;
013d97e9 Francesco Ruggeri 2012-01-16  6074  
013d97e9 Francesco Ruggeri 2012-01-16  6075  	if (!rtnl_trylock())
013d97e9 Francesco Ruggeri 2012-01-16  6076  		return restart_syscall();
56d417b1 Brian Haley       2009-06-01  6077  
56d417b1 Brian Haley       2009-06-01  6078  	net = (struct net *)table->extra2;
013d97e9 Francesco Ruggeri 2012-01-16  6079  	old = *p;
013d97e9 Francesco Ruggeri 2012-01-16  6080  	*p = newf;
56d417b1 Brian Haley       2009-06-01  6081  
013d97e9 Francesco Ruggeri 2012-01-16  6082  	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
013d97e9 Francesco Ruggeri 2012-01-16  6083  		rtnl_unlock();
56d417b1 Brian Haley       2009-06-01  6084  		return 0;
88af182e Eric W. Biederman 2010-02-19  6085  	}
56d417b1 Brian Haley       2009-06-01  6086  
56d417b1 Brian Haley       2009-06-01  6087  	if (p == &net->ipv6.devconf_all->disable_ipv6) {
56d417b1 Brian Haley       2009-06-01  6088  		net->ipv6.devconf_dflt->disable_ipv6 = newf;
56d417b1 Brian Haley       2009-06-01  6089  		addrconf_disable_change(net, newf);
013d97e9 Francesco Ruggeri 2012-01-16  6090  	} else if ((!newf) ^ (!old))
56d417b1 Brian Haley       2009-06-01  6091  		dev_disable_change((struct inet6_dev *)table->extra1);
56d417b1 Brian Haley       2009-06-01  6092  
56d417b1 Brian Haley       2009-06-01  6093  	rtnl_unlock();
56d417b1 Brian Haley       2009-06-01  6094  	return 0;
56d417b1 Brian Haley       2009-06-01  6095  }
56d417b1 Brian Haley       2009-06-01  6096  
56d417b1 Brian Haley       2009-06-01  6097  static
fe2c6338 Joe Perches       2013-06-11  6098  int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
56d417b1 Brian Haley       2009-06-01  6099  			    void __user *buffer, size_t *lenp, loff_t *ppos)
56d417b1 Brian Haley       2009-06-01  6100  {
56d417b1 Brian Haley       2009-06-01  6101  	int *valp = ctl->data;
56d417b1 Brian Haley       2009-06-01  6102  	int val = *valp;
88af182e Eric W. Biederman 2010-02-19  6103  	loff_t pos = *ppos;
fe2c6338 Joe Perches       2013-06-11  6104  	struct ctl_table lctl;
56d417b1 Brian Haley       2009-06-01  6105  	int ret;
56d417b1 Brian Haley       2009-06-01  6106  
013d97e9 Francesco Ruggeri 2012-01-16  6107  	/*
013d97e9 Francesco Ruggeri 2012-01-16  6108  	 * ctl->data points to idev->cnf.disable_ipv6, we should
013d97e9 Francesco Ruggeri 2012-01-16  6109  	 * not modify it until we get the rtnl lock.
013d97e9 Francesco Ruggeri 2012-01-16  6110  	 */
013d97e9 Francesco Ruggeri 2012-01-16  6111  	lctl = *ctl;
013d97e9 Francesco Ruggeri 2012-01-16  6112  	lctl.data = &val;
013d97e9 Francesco Ruggeri 2012-01-16  6113  
013d97e9 Francesco Ruggeri 2012-01-16  6114  	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
56d417b1 Brian Haley       2009-06-01  6115  
56d417b1 Brian Haley       2009-06-01  6116  	if (write)
56d417b1 Brian Haley       2009-06-01  6117  		ret = addrconf_disable_ipv6(ctl, valp, val);
88af182e Eric W. Biederman 2010-02-19  6118  	if (ret)
88af182e Eric W. Biederman 2010-02-19  6119  		*ppos = pos;
56d417b1 Brian Haley       2009-06-01  6120  	return ret;
56d417b1 Brian Haley       2009-06-01  6121  }
56d417b1 Brian Haley       2009-06-01  6122  
c92d5491 stephen hemminger 2013-12-17  6123  static
c92d5491 stephen hemminger 2013-12-17  6124  int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
c92d5491 stephen hemminger 2013-12-17  6125  			      void __user *buffer, size_t *lenp, loff_t *ppos)
c92d5491 stephen hemminger 2013-12-17  6126  {
c92d5491 stephen hemminger 2013-12-17  6127  	int *valp = ctl->data;
c92d5491 stephen hemminger 2013-12-17  6128  	int ret;
c92d5491 stephen hemminger 2013-12-17  6129  	int old, new;
c92d5491 stephen hemminger 2013-12-17  6130  
c92d5491 stephen hemminger 2013-12-17  6131  	old = *valp;
c92d5491 stephen hemminger 2013-12-17  6132  	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
c92d5491 stephen hemminger 2013-12-17  6133  	new = *valp;
c92d5491 stephen hemminger 2013-12-17  6134  
c92d5491 stephen hemminger 2013-12-17  6135  	if (write && old != new) {
c92d5491 stephen hemminger 2013-12-17 @6136  		struct net *net = ctl->extra2;
c92d5491 stephen hemminger 2013-12-17  6137  
c92d5491 stephen hemminger 2013-12-17  6138  		if (!rtnl_trylock())
c92d5491 stephen hemminger 2013-12-17  6139  			return restart_syscall();
c92d5491 stephen hemminger 2013-12-17  6140  
c92d5491 stephen hemminger 2013-12-17  6141  		if (valp == &net->ipv6.devconf_dflt->proxy_ndp)
85b3daad David Ahern       2017-03-28  6142  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
85b3daad David Ahern       2017-03-28  6143  						     NETCONFA_PROXY_NEIGH,
c92d5491 stephen hemminger 2013-12-17  6144  						     NETCONFA_IFINDEX_DEFAULT,
c92d5491 stephen hemminger 2013-12-17  6145  						     net->ipv6.devconf_dflt);
c92d5491 stephen hemminger 2013-12-17  6146  		else if (valp == &net->ipv6.devconf_all->proxy_ndp)
85b3daad David Ahern       2017-03-28  6147  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
85b3daad David Ahern       2017-03-28  6148  						     NETCONFA_PROXY_NEIGH,
c92d5491 stephen hemminger 2013-12-17  6149  						     NETCONFA_IFINDEX_ALL,
c92d5491 stephen hemminger 2013-12-17  6150  						     net->ipv6.devconf_all);
c92d5491 stephen hemminger 2013-12-17  6151  		else {
c92d5491 stephen hemminger 2013-12-17  6152  			struct inet6_dev *idev = ctl->extra1;
c92d5491 stephen hemminger 2013-12-17  6153  
85b3daad David Ahern       2017-03-28  6154  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
85b3daad David Ahern       2017-03-28  6155  						     NETCONFA_PROXY_NEIGH,
c92d5491 stephen hemminger 2013-12-17  6156  						     idev->dev->ifindex,
c92d5491 stephen hemminger 2013-12-17  6157  						     &idev->cnf);
c92d5491 stephen hemminger 2013-12-17  6158  		}
c92d5491 stephen hemminger 2013-12-17  6159  		rtnl_unlock();
c92d5491 stephen hemminger 2013-12-17  6160  	}
c92d5491 stephen hemminger 2013-12-17  6161  
c92d5491 stephen hemminger 2013-12-17  6162  	return ret;
c92d5491 stephen hemminger 2013-12-17  6163  }
c92d5491 stephen hemminger 2013-12-17  6164  

:::::: The code at line 6029 was first introduced by commit
:::::: 77751427a1ff25b27d47a4c36b12c3c8667855ac ipv6: addrconf: validate new MTU before applying it

:::::: TO: Marcelo Leitner <mleitner@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
