Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2940B34C4CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 09:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhC2HWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 03:22:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:52763 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhC2HVp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:21:45 -0400
IronPort-SDR: Ui8Qdoy6HmUspQ5nB71utYfOwBZhMW6uymyfKgHOcNDS+Vux78638vRaM0ANCvY/WlXciu8MNw
 CjXOwyGL4SCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191593759"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="xz'?yaml'?scan'208";a="191593759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:21:43 -0700
IronPort-SDR: Px8y97B/eUG3iLIf9cOZoZVRMmy11uRD+M6hScJpM4Ox6NfAN5VrHakcZL7iaZzU7U6hxA4afJ
 xICumnL/DWeQ==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="xz'?yaml'?scan'208";a="410947912"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:21:38 -0700
Date:   Mon, 29 Mar 2021 15:19:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [fs]  d7b0df2133: kernel-selftests.seccomp.seccomp_bpf.fail
Message-ID: <20210329071939.GC3633@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20210325082209.1067987-2-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: d7b0df2133729b8f9c9473d4af742d08e1d89453 ("[PATCH] fs: split receive_fd_replace from __receive_fd")
url: https://github.com/0day-ci/linux/commits/Christoph-Hellwig/fs-split-receive_fd_replace-from-__receive_fd/20210325-162437
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e138138003eb3b3d06cc91cf2e8c5dec77e2a31e

in testcase: kernel-selftests
version: kernel-selftests-x86_64-76bfc185-1_20210326
with following parameters:

	group: group-s
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453
2021-03-26 22:48:28 ln -sf /usr/bin/clang
2021-03-26 22:48:28 ln -sf /usr/bin/llc
2021-03-26 22:48:28 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
safesetid test: not in Makefile
2021-03-26 22:48:28 make TARGETS=safesetid
make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
gcc -Wall -O2    safesetid-test.c -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid/safesetid-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
LKP WARN miss target safesetid
2021-03-26 22:48:57 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:48:58 cp seccomp/settings /kselftests/seccomp/settings
2021-03-26 22:48:58 /kselftests/run_kselftest.sh -c seccomp
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# # seccomp_bpf.c:4022:user_notification_addfd:Expected fd (-1) >= 0 (0)
# # seccomp_bpf.c:4023:user_notification_addfd:Expected filecmp(getpid(), pid, memfd, fd) (-1) == 0 (0)
# # seccomp_bpf.c:4029:user_notification_addfd:Expected fd (-1) >= 0 (0)
# # user_notification_addfd: Test failed at step #5
# #          FAIL  global.user_notification_addfd
# not ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# # seccomp_bpf.c:4117:user_notification_addfd_rlimit:Expected errno (9) == EMFILE (24)
# # user_notification_addfd_rlimit: Test failed at step #6
# #          FAIL  global.user_notification_addfd_rlimit
# not ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # FAILED: 85 / 87 tests passed.
# # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=1
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable = 1
# net.core.bpf_jit_harden = 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 17951400 syscalls...
# 14.787353562 - 0.997474248 = 13789879314 (13.8s)
# getpid native: 768 ns
# 28.919353611 - 14.787576073 = 14131777538 (14.1s)
# getpid RET_ALLOW 1 filter (bitmap): 787 ns
# 41.811151704 - 28.919561008 = 12891590696 (12.9s)
# getpid RET_ALLOW 2 filters (bitmap): 718 ns
# 57.568729311 - 41.811331923 = 15757397388 (15.8s)
# getpid RET_ALLOW 3 filters (full): 877 ns
# 74.191105888 - 57.568946778 = 16622159110 (16.6s)
# getpid RET_ALLOW 4 filters (full): 925 ns
# Estimated total seccomp overhead for 1 bitmapped filter: 19 ns
# Estimated total seccomp overhead for 2 bitmapped filters: 18446744073709551566 ns
# Saw unexpected benchmark result. Try running again with more samples?
ok 2 selftests: seccomp: seccomp_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:14 /kselftests/run_kselftest.sh -c sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:14 /kselftests/run_kselftest.sh -c size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32739088
#  Free:   29326016
#  Buffer: 4
#  In use: 3413068
#  ...
# 1..1
ok 1 selftests: size: get_size
LKP WARN miss target sparc64
2021-03-26 22:50:14 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/sparc64'
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:14 cp splice/settings /kselftests/splice/settings
2021-03-26 22:50:14 /kselftests/run_kselftest.sh -c splice
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/10532/limits 4096
# splice: Invalid argument
# FAIL: /proc/10532/limits 2
# splice: Invalid argument
# FAIL: /proc/10532/comm 4096
# splice: Invalid argument
# FAIL: /proc/10532/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# ok: /sys/module/test_module/coresize 4096
# ok: /sys/module/test_module/coresize 2
# ok: /sys/module/test_module/sections/.init.text 4096
# ok: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=1
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:15 /kselftests/run_kselftest.sh -c static_keys
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
LKP WARN miss config CONFIG_SYNC= of sync/config
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:15 /kselftests/run_kselftest.sh -c sync
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:18 /kselftests/run_kselftest.sh -c syscall_user_dispatch
TAP version 13
1..2
# selftests: syscall_user_dispatch: sud_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.dispatch_trigger_sigsys ...
# #            OK  global.dispatch_trigger_sigsys
# ok 1 global.dispatch_trigger_sigsys
# #  RUN           global.bad_prctl_param ...
# #            OK  global.bad_prctl_param
# ok 2 global.bad_prctl_param
# #  RUN           global.dispatch_and_return ...
# #            OK  global.dispatch_and_return
# ok 3 global.dispatch_and_return
# #  RUN           global.bad_selector ...
# #            OK  global.bad_selector
# ok 4 global.bad_selector
# #  RUN           global.disable_dispatch ...
# #            OK  global.disable_dispatch
# ok 5 global.disable_dispatch
# #  RUN           global.direct_dispatch_range ...
# #            OK  global.direct_dispatch_range
# ok 6 global.direct_dispatch_range
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: syscall_user_dispatch: sud_test
# selftests: syscall_user_dispatch: sud_benchmark
# Enabling syscall trapping.
# Caught sys_ff00
# Calibrating test set to last ~5 seconds...
# test iterations = 4000000
# Avg syscall time 1344ns.
# trapped_call_count 1, native_call_count 0.
# Avg syscall time 1379ns.
# Interception overhead: 2.6% (+35ns).
ok 2 selftests: syscall_user_dispatch: sud_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:30 /kselftests/run_kselftest.sh -c sysctl
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Fri Mar 26 22:50:30 UTC 2021
# Running test: sysctl_test_0001 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Fri Mar 26 22:50:30 UTC 2021
# Running test: sysctl_test_0002 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/string_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0003 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0002 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0004 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Fri Mar 26 22:50:32 UTC 2021
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Fri Mar 26 22:50:32 UTC 2021
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Fri Mar 26 22:50:33 UTC 2021
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Fri Mar 26 22:50:33 UTC 2021
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Fri Mar 26 22:50:36 UTC 2021
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Fri Mar 26 22:50:36 UTC 2021
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Fri Mar 26 22:50:38 UTC 2021
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Fri Mar 26 22:50:39 UTC 2021
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Fri Mar 26 22:50:40 UTC 2021
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Fri Mar 26 22:50:41 UTC 2021
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Fri Mar 26 22:50:42 UTC 2021
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Fri Mar 26 22:50:43 UTC 2021
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Fri Mar 26 22:50:44 UTC 2021
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Fri Mar 26 22:50:44 UTC 2021
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Fri Mar 26 22:50:45 UTC 2021
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Fri Mar 26 22:50:45 UTC 2021
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Fri Mar 26 22:50:46 UTC 2021
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Fri Mar 26 22:50:46 UTC 2021
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Fri Mar 26 22:50:48 UTC 2021
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Fri Mar 26 22:50:50 UTC 2021
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Fri Mar 26 22:50:51 UTC 2021
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Fri Mar 26 22:50:51 UTC 2021
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Fri Mar 26 22:50:52 UTC 2021
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Fri Mar 26 22:50:53 UTC 2021
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Fri Mar 26 22:50:54 UTC 2021
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Fri Mar 26 22:50:54 UTC 2021
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Fri Mar 26 22:50:55 UTC 2021
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Fri Mar 26 22:50:55 UTC 2021
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Fri Mar 26 22:50:57 UTC 2021
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Fri Mar 26 22:50:57 UTC 2021
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Fri Mar 26 22:50:58 UTC 2021
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Fri Mar 26 22:50:58 UTC 2021
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Fri Mar 26 22:50:58 UTC 2021
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Fri Mar 26 22:50:59 UTC 2021
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Fri Mar 26 22:51:00 UTC 2021
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Fri Mar 26 22:51:02 UTC 2021
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Fri Mar 26 22:51:02 UTC 2021
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Fri Mar 26 22:51:02 UTC 2021
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Fri Mar 26 22:51:03 UTC 2021
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Fri Mar 26 22:51:03 UTC 2021
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Fri Mar 26 22:51:03 UTC 2021
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Fri Mar 26 22:51:04 UTC 2021
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Fri Mar 26 22:51:05 UTC 2021
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...ok
ok 1 selftests: sysctl: sysctl.sh



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc4-00224-gd7b0df213372"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_WIMAX is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='sysctl.debug.test_sysctl.boot_int=1'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='605e62416bf0db26a3aa2cf6'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7b0df2133729b8f9c9473d4af742d08e1d89453-20210327-9891-14pozj9-1.yaml'
	export id='9c08807a520ecda36a524fde00c9324c94f9cc43'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export commit='d7b0df2133729b8f9c9473d4af742d08e1d89453'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kselftests=true
	export need_kconfig='CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_PID_NS=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_USER_NS=y
CONFIG_TEST_LKM=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_STAGING=y
CONFIG_ANDROID=y
CONFIG_SYNC=y ~ "<= v4.7"
CONFIG_SW_SYNC=y
CONFIG_GENERIC_ENTRY=y
CONFIG_TEST_SYSCTL=y
CONFIG_X86_SGX=y ~ ">= v5.11-rc1"'
	export enqueue_time='2021-03-27 06:37:53 +0800'
	export _id='605e62416bf0db26a3aa2cf6'
	export _rt='/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='716a6461980c64c346a5f9baac42a7859dbc5fd7'
	export base_commit='0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b'
	export branch='linux-review/Christoph-Hellwig/fs-split-receive_fd_replace-from-__receive_fd/20210325-162437'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/3'
	export scheduler_version='/lkp/lkp/.src-20210326-165251'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7b0df2133729b8f9c9473d4af742d08e1d89453-20210327-9891-14pozj9-1.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linux-review/Christoph-Hellwig/fs-split-receive_fd_replace-from-__receive_fd/20210325-162437
commit=d7b0df2133729b8f9c9473d4af742d08e1d89453
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/vmlinuz-5.12.0-rc4-00224-gd7b0df213372
sysctl.debug.test_sysctl.boot_int=1
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/linux-selftests.cgz'
	export kselftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/kselftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210326.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-76bfc185-1_20210326.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc4-03685-g716a6461980c'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/vmlinuz-5.12.0-rc4-00224-gd7b0df213372'
	export dequeue_time='2021-03-27 06:47:07 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7b0df2133729b8f9c9473d4af742d08e1d89453-20210327-9891-14pozj9-1.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-s' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-s' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--wxDdMuZNg1r63Hyj
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453
2021-03-26 22:48:28 ln -sf /usr/bin/clang
2021-03-26 22:48:28 ln -sf /usr/bin/llc
2021-03-26 22:48:28 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
safesetid test: not in Makefile
2021-03-26 22:48:28 make TARGETS=safesetid
make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
gcc -Wall -O2    safesetid-test.c -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid/safesetid-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
LKP WARN miss target safesetid
2021-03-26 22:48:57 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/safesetid'
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:48:58 cp seccomp/settings /kselftests/seccomp/settings
2021-03-26 22:48:58 /kselftests/run_kselftest.sh -c seccomp
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# # seccomp_bpf.c:4022:user_notification_addfd:Expected fd (-1) >= 0 (0)
# # seccomp_bpf.c:4023:user_notification_addfd:Expected filecmp(getpid(), pid, memfd, fd) (-1) == 0 (0)
# # seccomp_bpf.c:4029:user_notification_addfd:Expected fd (-1) >= 0 (0)
# # user_notification_addfd: Test failed at step #5
# #          FAIL  global.user_notification_addfd
# not ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# # seccomp_bpf.c:4117:user_notification_addfd_rlimit:Expected errno (9) == EMFILE (24)
# # user_notification_addfd_rlimit: Test failed at step #6
# #          FAIL  global.user_notification_addfd_rlimit
# not ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # FAILED: 85 / 87 tests passed.
# # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=1
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable = 1
# net.core.bpf_jit_harden = 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 17951400 syscalls...
# 14.787353562 - 0.997474248 = 13789879314 (13.8s)
# getpid native: 768 ns
# 28.919353611 - 14.787576073 = 14131777538 (14.1s)
# getpid RET_ALLOW 1 filter (bitmap): 787 ns
# 41.811151704 - 28.919561008 = 12891590696 (12.9s)
# getpid RET_ALLOW 2 filters (bitmap): 718 ns
# 57.568729311 - 41.811331923 = 15757397388 (15.8s)
# getpid RET_ALLOW 3 filters (full): 877 ns
# 74.191105888 - 57.568946778 = 16622159110 (16.6s)
# getpid RET_ALLOW 4 filters (full): 925 ns
# Estimated total seccomp overhead for 1 bitmapped filter: 19 ns
# Estimated total seccomp overhead for 2 bitmapped filters: 18446744073709551566 ns
# Saw unexpected benchmark result. Try running again with more samples?
ok 2 selftests: seccomp: seccomp_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:14 /kselftests/run_kselftest.sh -c sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:14 /kselftests/run_kselftest.sh -c size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32739088
#  Free:   29326016
#  Buffer: 4
#  In use: 3413068
#  ...
# 1..1
ok 1 selftests: size: get_size
LKP WARN miss target sparc64
2021-03-26 22:50:14 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d7b0df2133729b8f9c9473d4af742d08e1d89453/tools/testing/selftests/sparc64'
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:14 cp splice/settings /kselftests/splice/settings
2021-03-26 22:50:14 /kselftests/run_kselftest.sh -c splice
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/10532/limits 4096
# splice: Invalid argument
# FAIL: /proc/10532/limits 2
# splice: Invalid argument
# FAIL: /proc/10532/comm 4096
# splice: Invalid argument
# FAIL: /proc/10532/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# ok: /sys/module/test_module/coresize 4096
# ok: /sys/module/test_module/coresize 2
# ok: /sys/module/test_module/sections/.init.text 4096
# ok: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=1
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:15 /kselftests/run_kselftest.sh -c static_keys
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
LKP WARN miss config CONFIG_SYNC= of sync/config
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:15 /kselftests/run_kselftest.sh -c sync
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:18 /kselftests/run_kselftest.sh -c syscall_user_dispatch
TAP version 13
1..2
# selftests: syscall_user_dispatch: sud_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.dispatch_trigger_sigsys ...
# #            OK  global.dispatch_trigger_sigsys
# ok 1 global.dispatch_trigger_sigsys
# #  RUN           global.bad_prctl_param ...
# #            OK  global.bad_prctl_param
# ok 2 global.bad_prctl_param
# #  RUN           global.dispatch_and_return ...
# #            OK  global.dispatch_and_return
# ok 3 global.dispatch_and_return
# #  RUN           global.bad_selector ...
# #            OK  global.bad_selector
# ok 4 global.bad_selector
# #  RUN           global.disable_dispatch ...
# #            OK  global.disable_dispatch
# ok 5 global.disable_dispatch
# #  RUN           global.direct_dispatch_range ...
# #            OK  global.direct_dispatch_range
# ok 6 global.direct_dispatch_range
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: syscall_user_dispatch: sud_test
# selftests: syscall_user_dispatch: sud_benchmark
# Enabling syscall trapping.
# Caught sys_ff00
# Calibrating test set to last ~5 seconds...
# test iterations = 4000000
# Avg syscall time 1344ns.
# trapped_call_count 1, native_call_count 0.
# Avg syscall time 1379ns.
# Interception overhead: 2.6% (+35ns).
ok 2 selftests: syscall_user_dispatch: sud_benchmark
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
2021-03-26 22:50:30 /kselftests/run_kselftest.sh -c sysctl
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Fri Mar 26 22:50:30 UTC 2021
# Running test: sysctl_test_0001 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Fri Mar 26 22:50:30 UTC 2021
# Running test: sysctl_test_0002 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/string_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0003 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_0002 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0004 - run #0
# == Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0001 ==
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Fri Mar 26 22:50:31 UTC 2021
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Fri Mar 26 22:50:32 UTC 2021
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Fri Mar 26 22:50:32 UTC 2021
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Fri Mar 26 22:50:33 UTC 2021
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Fri Mar 26 22:50:33 UTC 2021
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Fri Mar 26 22:50:34 UTC 2021
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Fri Mar 26 22:50:36 UTC 2021
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Fri Mar 26 22:50:36 UTC 2021
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Fri Mar 26 22:50:38 UTC 2021
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Fri Mar 26 22:50:39 UTC 2021
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Fri Mar 26 22:50:40 UTC 2021
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Fri Mar 26 22:50:41 UTC 2021
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Fri Mar 26 22:50:42 UTC 2021
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Fri Mar 26 22:50:43 UTC 2021
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Fri Mar 26 22:50:44 UTC 2021
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Fri Mar 26 22:50:44 UTC 2021
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Fri Mar 26 22:50:45 UTC 2021
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Fri Mar 26 22:50:45 UTC 2021
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Fri Mar 26 22:50:46 UTC 2021
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Fri Mar 26 22:50:46 UTC 2021
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Fri Mar 26 22:50:47 UTC 2021
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Fri Mar 26 22:50:48 UTC 2021
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Fri Mar 26 22:50:50 UTC 2021
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Fri Mar 26 22:50:51 UTC 2021
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Fri Mar 26 22:50:51 UTC 2021
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Fri Mar 26 22:50:52 UTC 2021
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Fri Mar 26 22:50:53 UTC 2021
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Fri Mar 26 22:50:54 UTC 2021
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Fri Mar 26 22:50:54 UTC 2021
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Fri Mar 26 22:50:55 UTC 2021
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Fri Mar 26 22:50:55 UTC 2021
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Fri Mar 26 22:50:57 UTC 2021
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Fri Mar 26 22:50:57 UTC 2021
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Fri Mar 26 22:50:58 UTC 2021
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Fri Mar 26 22:50:58 UTC 2021
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Fri Mar 26 22:50:58 UTC 2021
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Fri Mar 26 22:50:59 UTC 2021
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Fri Mar 26 22:51:00 UTC 2021
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Fri Mar 26 22:51:02 UTC 2021
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Fri Mar 26 22:51:02 UTC 2021
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Fri Mar 26 22:51:02 UTC 2021
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Fri Mar 26 22:51:03 UTC 2021
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Fri Mar 26 22:51:03 UTC 2021
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Fri Mar 26 22:51:03 UTC 2021
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Fri Mar 26 22:51:04 UTC 2021
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Fri Mar 26 22:51:05 UTC 2021
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...ok
ok 1 selftests: sysctl: sysctl.sh

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
need_memory: 3G
need_cpu: 2
kernel-selftests:
  group: group-s
kernel_cmdline: sysctl.debug.test_sysctl.boot_int=1
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 605e22176bf0db150476fab1
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7b0df2133729b8f9c9473d4af742d08e1d89453-20210327-5380-13ft59q-0.yaml"
id: ede8f59ef38f271c9570f1bbfe5d31c35fa6d7b5
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: d7b0df2133729b8f9c9473d4af742d08e1d89453

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

# for sysctl

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kselftests: true
need_kconfig:
- CONFIG_SECURITY=y
- CONFIG_SECURITYFS=y
- CONFIG_PID_NS=y
- CONFIG_SECCOMP=y
- CONFIG_SECCOMP_FILTER=y
- CONFIG_USER_NS=y
- CONFIG_TEST_LKM=m
- CONFIG_TEST_STATIC_KEYS=m
- CONFIG_STAGING=y
- CONFIG_ANDROID=y
- CONFIG_SYNC=y ~ "<= v4.7"
- CONFIG_SW_SYNC=y
- CONFIG_GENERIC_ENTRY=y
- CONFIG_TEST_SYSCTL=y
- CONFIG_X86_SGX=y ~ ">= v5.11-rc1"
enqueue_time: 2021-03-27 02:04:07.927301245 +08:00
_id: 605e22176bf0db150476fab1
_rt: "/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 716a6461980c64c346a5f9baac42a7859dbc5fd7
base_commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
branch: linux-devel/devel-hourly-20210326-132448
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/0"
scheduler_version: "/lkp/lkp/.src-20210326-165251"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d7b0df2133729b8f9c9473d4af742d08e1d89453-20210327-5380-13ft59q-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210326-132448
- commit=d7b0df2133729b8f9c9473d4af742d08e1d89453
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/vmlinuz-5.12.0-rc4-00224-gd7b0df213372
- sysctl.debug.test_sysctl.boot_int=1
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/linux-selftests.cgz"
kselftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/kselftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210326.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-76bfc185-1_20210326.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210325-154047/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc4

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d7b0df2133729b8f9c9473d4af742d08e1d89453/vmlinuz-5.12.0-rc4-00224-gd7b0df213372"
dequeue_time: 2021-03-27 02:42:24.825466207 +08:00

#! /lkp/lkp/.src-20210326-165251/include/site/inn
job_state: finished
loadavg: 1.09 0.62 0.26 1/143 12001
start_time: '1616784246'
end_time: '1616784407'
version: "/lkp/lkp/.src-20210326-165324:c11ec766:d45f7582b"

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make TARGETS=safesetid
make run_tests -C safesetid
cp seccomp/settings /kselftests/seccomp/settings
/kselftests/run_kselftest.sh -c seccomp
/kselftests/run_kselftest.sh -c sigaltstack
/kselftests/run_kselftest.sh -c size
make run_tests -C sparc64
cp splice/settings /kselftests/splice/settings
/kselftests/run_kselftest.sh -c splice
/kselftests/run_kselftest.sh -c static_keys
/kselftests/run_kselftest.sh -c sync
/kselftests/run_kselftest.sh -c syscall_user_dispatch
/kselftests/run_kselftest.sh -c sysctl

--wxDdMuZNg1r63Hyj--
