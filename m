Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE76BA160
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2019 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfIVHli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Sep 2019 03:41:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:14748 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfIVHli (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Sep 2019 03:41:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2019 00:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,535,1559545200"; 
   d="gz'50?scan'50,208,50";a="192777689"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.135])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2019 00:41:33 -0700
Date:   Sun, 22 Sep 2019 15:47:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190922074725.GH13569@xsang-OptiPlex-9020>
Reply-To: kbuild test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <156896493723.4334.13340481207144634918.stgit@buzz>
user-agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Konstantin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3 next-20190919]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Konstantin-Khlebnikov/mm-implement-write-behind-policy-for-sequential-file-writes/20190920-155606
reproduce: make htmldocs
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:132: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:238: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source gpu_info FW provided soc bounding box struct or 0 if not
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'soc_bounding_box' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'register_hpd_handlers' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_crtc_high_irq' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_pflip_high_irq' not found
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
   fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   kernel/dma/coherent.c:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
   drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
   mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
>> mm/filemap.c:3551: warning: Function parameter or member 'iocb' not described in 'generic_write_behind'
>> mm/filemap.c:3551: warning: Function parameter or member 'count' not described in 'generic_write_behind'
   include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv' not described in 'drm_gem_shmem_object'
   include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv_list' not described in 'drm_gem_shmem_object'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL5' not described in enum 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL6' not described in enum 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL6' description in 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL5' description in 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:342: warning: Function parameter or member 'wakeref' not described in 'intel_shared_dpll'
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pinned_ctx' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id_mask' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_check_timer' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_wq' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pollin' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'periodic' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'period_exponent' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'oa_buffer' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/mcde/mcde_drv.c:1: warning: 'ST-Ericsson MCDE DRM Driver' not found
   include/net/cfg80211.h:1185: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
   include/net/mac80211.h:4056: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
   include/net/mac80211.h:2018: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
   Documentation/admin-guide/perf/imx-ddr.rst:21: WARNING: Unexpected indentation.
   Documentation/admin-guide/perf/imx-ddr.rst:34: WARNING: Unexpected indentation.
   Documentation/admin-guide/perf/imx-ddr.rst:40: WARNING: Unexpected indentation.
   Documentation/admin-guide/perf/imx-ddr.rst:45: WARNING: Unexpected indentation.
   Documentation/admin-guide/perf/imx-ddr.rst:52: WARNING: Unexpected indentation.
   Documentation/hwmon/inspur-ipsps1.rst:2: WARNING: Title underline too short.

# https://github.com/0day-ci/linux/commit/e0e7df8d5b71bf59ad93fe75e662c929b580d805
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout e0e7df8d5b71bf59ad93fe75e662c929b580d805
vim +3551 mm/filemap.c

e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3534  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3535  /**
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3536   * generic_write_behind() - writeback dirty pages behind current position.
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3537   *
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3538   * This function tracks writing position. If file has enough sequentially
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3539   * written data it starts background writeback and then waits for previous
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3540   * writeback initiated some iterations ago.
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3541   *
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3542   * Write-behind maintains per-file head cursor in file->f_write_behind and
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3543   * two windows around: background writeback before and pending data after.
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3544   *
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3545   * |<-wait-this->|           |<-send-this->|<---pending-write-behind--->|
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3546   * |<--async-write-behind--->|<--------previous-data------>|<-new-data->|
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3547   *              current head-^    new head-^              file position-^
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3548   */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3549  void generic_write_behind(struct kiocb *iocb, ssize_t count)
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3550  {
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20 @3551  	struct file *file = iocb->ki_filp;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3552  	struct address_space *mapping = file->f_mapping;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3553  	struct inode *inode = mapping->host;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3554  	struct backing_dev_info *bdi = inode_to_bdi(inode);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3555  	unsigned long window = READ_ONCE(bdi->write_behind_pages);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3556  	pgoff_t head = file->f_write_behind;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3557  	pgoff_t begin = (iocb->ki_pos - count) >> PAGE_SHIFT;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3558  	pgoff_t end = iocb->ki_pos >> PAGE_SHIFT;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3559  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3560  	/* Skip if write is random, direct, sync or disabled for disk */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3561  	if ((file->f_mode & FMODE_RANDOM) || !window ||
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3562  	    (iocb->ki_flags & (IOCB_DIRECT | IOCB_DSYNC)))
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3563  		return;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3564  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3565  	/* Skip non-sequential writes in strictly sequential mode. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3566  	if (vm_dirty_write_behind < 2 &&
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3567  	    iocb->ki_pos != i_size_read(inode) &&
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3568  	    !(iocb->ki_flags & IOCB_APPEND))
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3569  		return;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3570  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3571  	/* Contigious write and still within window. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3572  	if (end - head < window)
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3573  		return;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3574  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3575  	spin_lock(&file->f_lock);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3576  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3577  	/* Re-read under lock. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3578  	head = file->f_write_behind;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3579  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3580  	/* Non-contiguous, move head position. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3581  	if (head > end || begin - head > window) {
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3582  		/*
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3583  		 * Append might happen though multiple files or via new file
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3584  		 * every time. Align head cursor to cover previous appends.
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3585  		 */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3586  		if (iocb->ki_flags & IOCB_APPEND)
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3587  			begin = roundup(begin - min(begin, window - 1),
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3588  					bdi->io_pages);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3589  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3590  		file->f_write_behind = head = begin;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3591  	}
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3592  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3593  	/* Still not big enough. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3594  	if (end - head < window) {
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3595  		spin_unlock(&file->f_lock);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3596  		return;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3597  	}
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3598  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3599  	/* Write excess and try at least max_sectors_kb if possible */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3600  	end = head + max(end - head - window, min(end - head, bdi->io_pages));
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3601  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3602  	/* Set head for next iteration, everything behind will be written. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3603  	file->f_write_behind = end;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3604  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3605  	spin_unlock(&file->f_lock);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3606  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3607  	/* Start background writeback. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3608  	__filemap_fdatawrite_range(mapping,
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3609  				   (loff_t)head << PAGE_SHIFT,
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3610  				   ((loff_t)end << PAGE_SHIFT) - 1,
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3611  				   WB_SYNC_NONE);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3612  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3613  	if (head < window)
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3614  		return;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3615  
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3616  	/* Wait for pages falling behind writeback window. */
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3617  	head -= window;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3618  	end -= window;
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3619  	__filemap_fdatawait_range(mapping,
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3620  				  (loff_t)head << PAGE_SHIFT,
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3621  				  ((loff_t)end << PAGE_SHIFT) - 1);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3622  }
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3623  EXPORT_SYMBOL(generic_write_behind);
e0e7df8d5b71bf Konstantin Khlebnikov 2019-09-20  3624  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--svZFHVx8/dhPCe52
Content-Type: application/gzip; name=".config.gz"
Content-Description: .config.gz
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--svZFHVx8/dhPCe52--
