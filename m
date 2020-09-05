Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA14425E8B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIEPfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 11:35:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:49047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgIEPfa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:35:30 -0400
IronPort-SDR: aokCO65bEETooeiGnw9bi7T5tY6+JuLNo2mN2/RkhiCm68fbgDCJVtPWkb9cwrhHBQE4/SQenX
 dFWuEEtUSSIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219424418"
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="gz'50?scan'50,208,50";a="219424418"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 08:35:09 -0700
IronPort-SDR: AJEukLBQgh/SvuTHFCJa53it4tzKdeRDBBUjus+c5w9s+n8+mlDDFxIJ/wbvq/mYzFl1DJE19Z
 9tgxc5IdIWcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="gz'50?scan'50,208,50";a="340215099"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2020 08:35:06 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEaDa-0000GW-At; Sat, 05 Sep 2020 15:35:06 +0000
Date:   Sat, 5 Sep 2020 23:34:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [vfs:base.set_fs 14/14] net/sctp/socket.c:7793:12: warning: stack
 frame size of 1040 bytes in function 'sctp_getsockopt'
Message-ID: <202009052305.nGhLaan1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git base.set_fs
head:   5d6382ce08928178bb36704a743534fdcc28044e
commit: 5d6382ce08928178bb36704a743534fdcc28044e [14/14] powerpc: remove address space overrides using set_fs()
config: powerpc64-randconfig-r003-20200904 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 781a43840863b85603a710857691a9b5032b0c27)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        git checkout 5d6382ce08928178bb36704a743534fdcc28044e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sctp/socket.c:7793:12: warning: stack frame size of 1040 bytes in function 'sctp_getsockopt' [-Wframe-larger-than=]
   static int sctp_getsockopt(struct sock *sk, int level, int optname,
              ^
   1 warning generated.

# https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?id=5d6382ce08928178bb36704a743534fdcc28044e
git remote add vfs https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git fetch --no-tags vfs base.set_fs
git checkout 5d6382ce08928178bb36704a743534fdcc28044e
vim +/sctp_getsockopt +7793 net/sctp/socket.c

8d2a6935d842f1 Xin Long                2019-11-08  7792  
dda9192851dcf9 Daniel Borkmann         2013-06-17 @7793  static int sctp_getsockopt(struct sock *sk, int level, int optname,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7794  			   char __user *optval, int __user *optlen)
^1da177e4c3f41 Linus Torvalds          2005-04-16  7795  {
^1da177e4c3f41 Linus Torvalds          2005-04-16  7796  	int retval = 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7797  	int len;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7798  
bb33381d0c97cd Daniel Borkmann         2013-06-28  7799  	pr_debug("%s: sk:%p, optname:%d\n", __func__, sk, optname);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7800  
^1da177e4c3f41 Linus Torvalds          2005-04-16  7801  	/* I can hardly begin to describe how wrong this is.  This is
^1da177e4c3f41 Linus Torvalds          2005-04-16  7802  	 * so broken as to be worse than useless.  The API draft
^1da177e4c3f41 Linus Torvalds          2005-04-16  7803  	 * REALLY is NOT helpful here...  I am not convinced that the
^1da177e4c3f41 Linus Torvalds          2005-04-16  7804  	 * semantics of getsockopt() with a level OTHER THAN SOL_SCTP
^1da177e4c3f41 Linus Torvalds          2005-04-16  7805  	 * are at all well-founded.
^1da177e4c3f41 Linus Torvalds          2005-04-16  7806  	 */
^1da177e4c3f41 Linus Torvalds          2005-04-16  7807  	if (level != SOL_SCTP) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  7808  		struct sctp_af *af = sctp_sk(sk)->pf->af;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7809  
^1da177e4c3f41 Linus Torvalds          2005-04-16  7810  		retval = af->getsockopt(sk, level, optname, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7811  		return retval;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7812  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  7813  
^1da177e4c3f41 Linus Torvalds          2005-04-16  7814  	if (get_user(len, optlen))
^1da177e4c3f41 Linus Torvalds          2005-04-16  7815  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7816  
a4b8e71b05c27b Jiri Slaby              2016-10-21  7817  	if (len < 0)
a4b8e71b05c27b Jiri Slaby              2016-10-21  7818  		return -EINVAL;
a4b8e71b05c27b Jiri Slaby              2016-10-21  7819  
048ed4b6266144 wangweidong             2014-01-21  7820  	lock_sock(sk);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7821  
^1da177e4c3f41 Linus Torvalds          2005-04-16  7822  	switch (optname) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  7823  	case SCTP_STATUS:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7824  		retval = sctp_getsockopt_sctp_status(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7825  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7826  	case SCTP_DISABLE_FRAGMENTS:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7827  		retval = sctp_getsockopt_disable_fragments(sk, len, optval,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7828  							   optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7829  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7830  	case SCTP_EVENTS:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7831  		retval = sctp_getsockopt_events(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7832  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7833  	case SCTP_AUTOCLOSE:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7834  		retval = sctp_getsockopt_autoclose(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7835  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7836  	case SCTP_SOCKOPT_PEELOFF:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7837  		retval = sctp_getsockopt_peeloff(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7838  		break;
2cb5c8e378d10a Neil Horman             2017-06-30  7839  	case SCTP_SOCKOPT_PEELOFF_FLAGS:
2cb5c8e378d10a Neil Horman             2017-06-30  7840  		retval = sctp_getsockopt_peeloff_flags(sk, len, optval, optlen);
2cb5c8e378d10a Neil Horman             2017-06-30  7841  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7842  	case SCTP_PEER_ADDR_PARAMS:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7843  		retval = sctp_getsockopt_peer_addr_params(sk, len, optval,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7844  							  optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7845  		break;
4580ccc04ddd8c Shan Wei                2011-01-18  7846  	case SCTP_DELAYED_SACK:
d364d9276b54af Wei Yongjun             2008-05-09  7847  		retval = sctp_getsockopt_delayed_ack(sk, len, optval,
7708610b1bff4a Frank Filz              2005-12-22  7848  							  optlen);
7708610b1bff4a Frank Filz              2005-12-22  7849  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7850  	case SCTP_INITMSG:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7851  		retval = sctp_getsockopt_initmsg(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7852  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7853  	case SCTP_GET_PEER_ADDRS:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7854  		retval = sctp_getsockopt_peer_addrs(sk, len, optval,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7855  						    optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7856  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7857  	case SCTP_GET_LOCAL_ADDRS:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7858  		retval = sctp_getsockopt_local_addrs(sk, len, optval,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7859  						     optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7860  		break;
c6ba68a26645db Vlad Yasevich           2009-06-01  7861  	case SCTP_SOCKOPT_CONNECTX3:
c6ba68a26645db Vlad Yasevich           2009-06-01  7862  		retval = sctp_getsockopt_connectx3(sk, len, optval, optlen);
c6ba68a26645db Vlad Yasevich           2009-06-01  7863  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7864  	case SCTP_DEFAULT_SEND_PARAM:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7865  		retval = sctp_getsockopt_default_send_param(sk, len,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7866  							    optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7867  		break;
6b3fd5f3a2bbc8 Geir Ola Vaagland       2014-07-12  7868  	case SCTP_DEFAULT_SNDINFO:
6b3fd5f3a2bbc8 Geir Ola Vaagland       2014-07-12  7869  		retval = sctp_getsockopt_default_sndinfo(sk, len,
6b3fd5f3a2bbc8 Geir Ola Vaagland       2014-07-12  7870  							 optval, optlen);
6b3fd5f3a2bbc8 Geir Ola Vaagland       2014-07-12  7871  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7872  	case SCTP_PRIMARY_ADDR:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7873  		retval = sctp_getsockopt_primary_addr(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7874  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7875  	case SCTP_NODELAY:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7876  		retval = sctp_getsockopt_nodelay(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7877  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7878  	case SCTP_RTOINFO:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7879  		retval = sctp_getsockopt_rtoinfo(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7880  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7881  	case SCTP_ASSOCINFO:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7882  		retval = sctp_getsockopt_associnfo(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7883  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7884  	case SCTP_I_WANT_MAPPED_V4_ADDR:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7885  		retval = sctp_getsockopt_mappedv4(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7886  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7887  	case SCTP_MAXSEG:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7888  		retval = sctp_getsockopt_maxseg(sk, len, optval, optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7889  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  7890  	case SCTP_GET_PEER_ADDR_INFO:
^1da177e4c3f41 Linus Torvalds          2005-04-16  7891  		retval = sctp_getsockopt_peer_addr_info(sk, len, optval,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7892  							optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7893  		break;
0f3fffd8ab1db7 Ivan Skytte Jorgensen   2006-12-20  7894  	case SCTP_ADAPTATION_LAYER:
0f3fffd8ab1db7 Ivan Skytte Jorgensen   2006-12-20  7895  		retval = sctp_getsockopt_adaptation_layer(sk, len, optval,
^1da177e4c3f41 Linus Torvalds          2005-04-16  7896  							optlen);
^1da177e4c3f41 Linus Torvalds          2005-04-16  7897  		break;
6ab792f5770123 Ivan Skytte Jorgensen   2006-12-13  7898  	case SCTP_CONTEXT:
6ab792f5770123 Ivan Skytte Jorgensen   2006-12-13  7899  		retval = sctp_getsockopt_context(sk, len, optval, optlen);
6ab792f5770123 Ivan Skytte Jorgensen   2006-12-13  7900  		break;
b6e1331f3ce25a Vlad Yasevich           2007-04-20  7901  	case SCTP_FRAGMENT_INTERLEAVE:
b6e1331f3ce25a Vlad Yasevich           2007-04-20  7902  		retval = sctp_getsockopt_fragment_interleave(sk, len, optval,
b6e1331f3ce25a Vlad Yasevich           2007-04-20  7903  							     optlen);
b6e1331f3ce25a Vlad Yasevich           2007-04-20  7904  		break;
d49d91d79a8dc5 Vlad Yasevich           2007-03-23  7905  	case SCTP_PARTIAL_DELIVERY_POINT:
d49d91d79a8dc5 Vlad Yasevich           2007-03-23  7906  		retval = sctp_getsockopt_partial_delivery_point(sk, len, optval,
d49d91d79a8dc5 Vlad Yasevich           2007-03-23  7907  								optlen);
d49d91d79a8dc5 Vlad Yasevich           2007-03-23  7908  		break;
703315712cfccf Vlad Yasevich           2007-03-23  7909  	case SCTP_MAX_BURST:
703315712cfccf Vlad Yasevich           2007-03-23  7910  		retval = sctp_getsockopt_maxburst(sk, len, optval, optlen);
703315712cfccf Vlad Yasevich           2007-03-23  7911  		break;
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7912  	case SCTP_AUTH_KEY:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7913  	case SCTP_AUTH_CHUNK:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7914  	case SCTP_AUTH_DELETE_KEY:
601590ec155aad Xin Long                2018-03-14  7915  	case SCTP_AUTH_DEACTIVATE_KEY:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7916  		retval = -EOPNOTSUPP;
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7917  		break;
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7918  	case SCTP_HMAC_IDENT:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7919  		retval = sctp_getsockopt_hmac_ident(sk, len, optval, optlen);
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7920  		break;
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7921  	case SCTP_AUTH_ACTIVE_KEY:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7922  		retval = sctp_getsockopt_active_key(sk, len, optval, optlen);
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7923  		break;
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7924  	case SCTP_PEER_AUTH_CHUNKS:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7925  		retval = sctp_getsockopt_peer_auth_chunks(sk, len, optval,
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7926  							optlen);
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7927  		break;
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7928  	case SCTP_LOCAL_AUTH_CHUNKS:
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7929  		retval = sctp_getsockopt_local_auth_chunks(sk, len, optval,
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7930  							optlen);
65b07e5d0d09c7 Vlad Yasevich           2007-09-16  7931  		break;
aea3c5c05d2c40 Wei Yongjun             2008-12-25  7932  	case SCTP_GET_ASSOC_NUMBER:
aea3c5c05d2c40 Wei Yongjun             2008-12-25  7933  		retval = sctp_getsockopt_assoc_number(sk, len, optval, optlen);
aea3c5c05d2c40 Wei Yongjun             2008-12-25  7934  		break;
209ba424c2c6e5 Wei Yongjun             2011-04-17  7935  	case SCTP_GET_ASSOC_ID_LIST:
209ba424c2c6e5 Wei Yongjun             2011-04-17  7936  		retval = sctp_getsockopt_assoc_ids(sk, len, optval, optlen);
209ba424c2c6e5 Wei Yongjun             2011-04-17  7937  		break;
7dc04d712203ee Michio Honda            2011-04-26  7938  	case SCTP_AUTO_ASCONF:
7dc04d712203ee Michio Honda            2011-04-26  7939  		retval = sctp_getsockopt_auto_asconf(sk, len, optval, optlen);
7dc04d712203ee Michio Honda            2011-04-26  7940  		break;
5aa93bcf66f4af Neil Horman             2012-07-21  7941  	case SCTP_PEER_ADDR_THLDS:
d467ac0a38551a Xin Long                2019-11-08  7942  		retval = sctp_getsockopt_paddr_thresholds(sk, optval, len,
d467ac0a38551a Xin Long                2019-11-08  7943  							  optlen, false);
d467ac0a38551a Xin Long                2019-11-08  7944  		break;
d467ac0a38551a Xin Long                2019-11-08  7945  	case SCTP_PEER_ADDR_THLDS_V2:
d467ac0a38551a Xin Long                2019-11-08  7946  		retval = sctp_getsockopt_paddr_thresholds(sk, optval, len,
d467ac0a38551a Xin Long                2019-11-08  7947  							  optlen, true);
5aa93bcf66f4af Neil Horman             2012-07-21  7948  		break;
196d67593439b0 Michele Baldessari      2012-12-01  7949  	case SCTP_GET_ASSOC_STATS:
196d67593439b0 Michele Baldessari      2012-12-01  7950  		retval = sctp_getsockopt_assoc_stats(sk, len, optval, optlen);
196d67593439b0 Michele Baldessari      2012-12-01  7951  		break;
0d3a421d284812 Geir Ola Vaagland       2014-07-12  7952  	case SCTP_RECVRCVINFO:
0d3a421d284812 Geir Ola Vaagland       2014-07-12  7953  		retval = sctp_getsockopt_recvrcvinfo(sk, len, optval, optlen);
0d3a421d284812 Geir Ola Vaagland       2014-07-12  7954  		break;
2347c80ff127b9 Geir Ola Vaagland       2014-07-12  7955  	case SCTP_RECVNXTINFO:
2347c80ff127b9 Geir Ola Vaagland       2014-07-12  7956  		retval = sctp_getsockopt_recvnxtinfo(sk, len, optval, optlen);
2347c80ff127b9 Geir Ola Vaagland       2014-07-12  7957  		break;
28aa4c26fce220 Xin Long                2016-07-09  7958  	case SCTP_PR_SUPPORTED:
28aa4c26fce220 Xin Long                2016-07-09  7959  		retval = sctp_getsockopt_pr_supported(sk, len, optval, optlen);
28aa4c26fce220 Xin Long                2016-07-09  7960  		break;
f959fb442c35f4 Xin Long                2016-07-09  7961  	case SCTP_DEFAULT_PRINFO:
f959fb442c35f4 Xin Long                2016-07-09  7962  		retval = sctp_getsockopt_default_prinfo(sk, len, optval,
f959fb442c35f4 Xin Long                2016-07-09  7963  							optlen);
f959fb442c35f4 Xin Long                2016-07-09  7964  		break;
826d253d57b11f Xin Long                2016-07-09  7965  	case SCTP_PR_ASSOC_STATUS:
826d253d57b11f Xin Long                2016-07-09  7966  		retval = sctp_getsockopt_pr_assocstatus(sk, len, optval,
826d253d57b11f Xin Long                2016-07-09  7967  							optlen);
826d253d57b11f Xin Long                2016-07-09  7968  		break;
d229d48d183fbc Xin Long                2017-04-01  7969  	case SCTP_PR_STREAM_STATUS:
d229d48d183fbc Xin Long                2017-04-01  7970  		retval = sctp_getsockopt_pr_streamstatus(sk, len, optval,
d229d48d183fbc Xin Long                2017-04-01  7971  							 optlen);
d229d48d183fbc Xin Long                2017-04-01  7972  		break;
c0d8bab6ae518c Xin Long                2017-03-10  7973  	case SCTP_RECONFIG_SUPPORTED:
c0d8bab6ae518c Xin Long                2017-03-10  7974  		retval = sctp_getsockopt_reconfig_supported(sk, len, optval,
c0d8bab6ae518c Xin Long                2017-03-10  7975  							    optlen);
c0d8bab6ae518c Xin Long                2017-03-10  7976  		break;
9fb657aec0e20b Xin Long                2017-01-18  7977  	case SCTP_ENABLE_STREAM_RESET:
9fb657aec0e20b Xin Long                2017-01-18  7978  		retval = sctp_getsockopt_enable_strreset(sk, len, optval,
9fb657aec0e20b Xin Long                2017-01-18  7979  							 optlen);
9fb657aec0e20b Xin Long                2017-01-18  7980  		break;
13aa8770fe42d2 Marcelo Ricardo Leitner 2017-10-03  7981  	case SCTP_STREAM_SCHEDULER:
13aa8770fe42d2 Marcelo Ricardo Leitner 2017-10-03  7982  		retval = sctp_getsockopt_scheduler(sk, len, optval,
13aa8770fe42d2 Marcelo Ricardo Leitner 2017-10-03  7983  						   optlen);
13aa8770fe42d2 Marcelo Ricardo Leitner 2017-10-03  7984  		break;
0ccdf3c7fdeda5 Marcelo Ricardo Leitner 2017-10-03  7985  	case SCTP_STREAM_SCHEDULER_VALUE:
0ccdf3c7fdeda5 Marcelo Ricardo Leitner 2017-10-03  7986  		retval = sctp_getsockopt_scheduler_value(sk, len, optval,
0ccdf3c7fdeda5 Marcelo Ricardo Leitner 2017-10-03  7987  							 optlen);
0ccdf3c7fdeda5 Marcelo Ricardo Leitner 2017-10-03  7988  		break;
772a58693fc311 Xin Long                2017-12-08  7989  	case SCTP_INTERLEAVING_SUPPORTED:
772a58693fc311 Xin Long                2017-12-08  7990  		retval = sctp_getsockopt_interleaving_supported(sk, len, optval,
772a58693fc311 Xin Long                2017-12-08  7991  								optlen);
772a58693fc311 Xin Long                2017-12-08  7992  		break;
b0e9a2fe3ff971 Xin Long                2018-06-28  7993  	case SCTP_REUSE_PORT:
b0e9a2fe3ff971 Xin Long                2018-06-28  7994  		retval = sctp_getsockopt_reuse_port(sk, len, optval, optlen);
b0e9a2fe3ff971 Xin Long                2018-06-28  7995  		break;
480ba9c18a27ff Xin Long                2018-11-18  7996  	case SCTP_EVENT:
480ba9c18a27ff Xin Long                2018-11-18  7997  		retval = sctp_getsockopt_event(sk, len, optval, optlen);
480ba9c18a27ff Xin Long                2018-11-18  7998  		break;
df2c71ffdfae58 Xin Long                2019-08-19  7999  	case SCTP_ASCONF_SUPPORTED:
df2c71ffdfae58 Xin Long                2019-08-19  8000  		retval = sctp_getsockopt_asconf_supported(sk, len, optval,
df2c71ffdfae58 Xin Long                2019-08-19  8001  							  optlen);
df2c71ffdfae58 Xin Long                2019-08-19  8002  		break;
56dd525abd56f7 Xin Long                2019-08-19  8003  	case SCTP_AUTH_SUPPORTED:
56dd525abd56f7 Xin Long                2019-08-19  8004  		retval = sctp_getsockopt_auth_supported(sk, len, optval,
56dd525abd56f7 Xin Long                2019-08-19  8005  							optlen);
56dd525abd56f7 Xin Long                2019-08-19  8006  		break;
d5886b919a720f Xin Long                2019-08-26  8007  	case SCTP_ECN_SUPPORTED:
d5886b919a720f Xin Long                2019-08-26  8008  		retval = sctp_getsockopt_ecn_supported(sk, len, optval, optlen);
d5886b919a720f Xin Long                2019-08-26  8009  		break;
8d2a6935d842f1 Xin Long                2019-11-08  8010  	case SCTP_EXPOSE_POTENTIALLY_FAILED_STATE:
8d2a6935d842f1 Xin Long                2019-11-08  8011  		retval = sctp_getsockopt_pf_expose(sk, len, optval, optlen);
8d2a6935d842f1 Xin Long                2019-11-08  8012  		break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  8013  	default:
^1da177e4c3f41 Linus Torvalds          2005-04-16  8014  		retval = -ENOPROTOOPT;
^1da177e4c3f41 Linus Torvalds          2005-04-16  8015  		break;
3ff50b7997fe06 Stephen Hemminger       2007-04-20  8016  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  8017  
048ed4b6266144 wangweidong             2014-01-21  8018  	release_sock(sk);
^1da177e4c3f41 Linus Torvalds          2005-04-16  8019  	return retval;
^1da177e4c3f41 Linus Torvalds          2005-04-16  8020  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  8021  

:::::: The code at line 7793 was first introduced by commit
:::::: dda9192851dcf904b4d1095480834f2a4f814ae3 net: sctp: remove SCTP_STATIC macro

:::::: TO: Daniel Borkmann <dborkman@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
mWi+meK5wHlYpW4d/wcs6xPkwBACAA==

--3MwIy2ne0vdjdPXF--
