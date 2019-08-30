Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7810A4074
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfH3WTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 18:19:24 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:40961
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728386AbfH3WTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567203560; bh=8Sd/zm7hfXjhWHKwPIDZ+8xNC/0LVI74hWoH0fbOUnE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=lCSXobEsaGz8cfS3qVrKsiHluT+qvD3dLTpWZyTh9HiLN+8U4wFyYPP+PCA4ZElSzQYg5/zfb266ipVPmzgLe/c+ncSa/vHGX++X+ID3WeQP2Zyt8MGJk9IpIaUGSMERwnMkpuXdYMDdpkL3co1PfdvG2XkgqxDJ3S6wOKahaOXw7nGBmjDnCV9/OB20TSZDAYHwgJKIuiLJBBsW+APwCzg7KyPchOqiav209vro8/rT0e1+7/R5Oekx+2lYp8xIpUOhTL21bXYBE91xkE1wrBd7YWNL86ymfInURhGZR6FkIvjcDz9Psxusgm1VmRsUFqL1PDC9uZhtNTbHEPZbNw==
X-YMail-OSG: jfdUunsVM1ktonP0k7pwu7SPkn3uKOb_0tQ6agL8IgMN9OZmvyon9ArsZxA1u.F
 Rq2Nc2CxzxHBI0atZ2e4f7uSGpkVpylyg1e8fBGPDVRGEQX00d2IemXyaoUkJvWrpAy75gDv0t9D
 PsIaj2BOW0IgKNLGo7a44y2Eg8xrsSl2p_wTeEQUBO2MI4KlN441m7ySc2zW7VdgmjXEuchDgvdI
 Ms.WcZQVC4J.qceaaYvl_hNTOT.W90KyKGAMBRFrQBJ04RR.Of42Ik9kKcJz4PiVAmRQhkaO_g._
 xgF2AodBp0W4PiN.q.gTyXjexyJcu5W2lT4mU5SzKrlHgm5KW0.IHOYxr8v8djoBKYuI1w.p7rNS
 JI7LWlRa9ZgSOrkpqCAFwfU028UvHkP0y0ZPtuaunds79sztTDmMgIW3UwPvUSG4uQV0vmNKaTQH
 wngQFqqlDI.3zlskA705Yj0ALxWyFb9idqkoFUM0RmNq3rysiAICRmIxau02NnRgvRgBROd9UUdz
 TuwsQ3oclRolne05CjR7KTcv7KF8H70BX2xlSqURaPR2ZzSW3IiDD950aSvRpju_P1VeoprkXxP2
 w7poUR2.ZJqu7OY0GxIGyY0l3E9QCce5ZKDR7s0.UwyYoAyq3V9glB6lKMf0SMSsAOPD4yM61o1z
 GdKa5I0rDJH.6.5FKqvF.899s.iKX8c7hHEKX8RmdsdLfoelNtqktFtND1pqE3H2yB0dWNMBrjpd
 bQmJJzzpJ1jutqykTHCXVSqb2q83RyMxT.cp9rrelSq.4SlWiq9C25R_.CfiMfeauBAvp1ElGTD4
 4Ex1Pk38bakv8WvXlRDhFoDJmrx5SYRPlbrkK3S6foF2ivYjvnnvBrApMiVreQ.AUQXq3Dt5Yq1K
 fcZCXpl0YPbgXI.Iip30YBMWWMIXGd7mOHhF54OSikVsuDDmR6kd3P0P0bmaWiE2N27y0RcAGPId
 KK043p4gk4vxhepohKH0EHiGAyuK9zcxOu3IIpUJvAQsHi2VGKfS9xfsk9GmzYPF_iGJ0k21RENe
 ErUdIKARdSpCgDAD.dmYlzCBB._9Iai5v4zVfpN45ICxmfnm3GjiGwX9dUPdhuKmIIvnXNdCXk2C
 Zmih_XON1dsQEv7rGEGBZg4NM2Hw2joURUG9MXaPtIrCVPKasuS2ZNGoF1EtI2rpJPSgg99qJUEh
 13Hi0doj7.ky0VJ5DfXsX6lOw_9_VY.cEYu6vjEGN23ooDWGvTmJL8lWni9Vn2OxzuMCfZ8WB188
 bCj1RpIp99lGTjY1lrkilX4wvK0uPVCiwH_7O.L.93UtPcBuujRaf0sneJGRRnBbyHfvxX6e3Day
 zYBiydSqjSmKmb_ccf1XyLo9ibQ13qw5FXj.robOKFHmOLq9YcBB1ecc.0zY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2019 22:19:20 +0000
Received: by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6ac79b7b692469d766cc49c89dd4ca2e;
          Fri, 30 Aug 2019 22:09:18 +0000 (UTC)
Subject: Re: [PATCH 00/11] Keyrings, Block and USB notifications [ver #7]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <563ae8b4-753a-179d-4f6d-94d2dd058f3b@schaufler-ca.com>
Date:   Fri, 30 Aug 2019 15:09:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/2019 6:57 AM, David Howells wrote:
> Here's a set of patches to add a general notification queue concept and to
> add sources of events for:
>
>  (1) Key/keyring events, such as creating, linking and removal of keys.
>
>  (2) General device events (single common queue) including:
>
>      - Block layer events, such as device errors
>
>      - USB subsystem events, such as device/bus attach/remove, device
>        reset, device errors.
>
> Tests for the key/keyring events can be found on the keyutils next branch:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=next

I'm having trouble with the "make install" on Fedora. Is there an
unusual dependency?

>
> Notifications are done automatically inside of the testing infrastructure
> on every change to that every test makes to a key or keyring.
>
> Manual pages can be found there also, including pages for watch_queue(7)
> and the watch_devices(2) system call (these should be transferred to the
> manpages package if taken upstream).
>
> LSM hooks are included:
>
>  (1) A set of hooks are provided that allow an LSM to rule on whether or
>      not a watch may be set.  Each of these hooks takes a different
>      "watched object" parameter, so they're not really shareable.  The LSM
>      should use current's credentials.  [Wanted by SELinux & Smack]
>
>  (2) A hook is provided to allow an LSM to rule on whether or not a
>      particular message may be posted to a particular queue.  This is given
>      the credentials from the event generator (which may be the system) and
>      the watch setter.  [Wanted by Smack]
>
> I've provided a preliminary attempt to provide SELinux and Smack with
> implementations of some of these hooks.
>
>
> Design decisions:
>
>  (1) A misc chardev is used to create and open a ring buffer:
>
> 	fd = open("/dev/watch_queue", O_RDWR);
>
>      which is then configured and mmap'd into userspace:
>
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> 	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
> 		   MAP_SHARED, fd, 0);
>
>      The fd cannot be read or written (though there is a facility to use
>      write to inject records for debugging) and userspace just pulls data
>      directly out of the buffer.
>
>  (2) The ring index pointers are stored inside the ring and are thus
>      accessible to userspace.  Userspace should only update the tail
>      pointer and never the head pointer or risk breaking the buffer.  The
>      kernel checks that the pointers appear valid before trying to use
>      them.  A 'skip' record is maintained around the pointers.
>
>  (3) poll() can be used to wait for data to appear in the buffer.
>
>  (4) Records in the buffer are binary, typed and have a length so that they
>      can be of varying size.
>
>      This means that multiple heterogeneous sources can share a common
>      buffer.  Tags may be specified when a watchpoint is created to help
>      distinguish the sources.
>
>  (5) The queue is reusable as there are 16 million types available, of
>      which I've used just a few, so there is scope for others to be used.
>
>  (6) Records are filterable as types have up to 256 subtypes that can be
>      individually filtered.  Other filtration is also available.
>
>  (7) Each time the buffer is opened, a new buffer is created - this means
>      that there's no interference between watchers.
>
>  (8) When recording a notification, the kernel will not sleep, but will
>      rather mark a queue as overrun if there's insufficient space, thereby
>      avoiding userspace causing the kernel to hang.
>
>  (9) The 'watchpoint' should be specific where possible, meaning that you
>      specify the object that you want to watch.
>
> (10) The buffer is created and then watchpoints are attached to it, using
>      one of:
>
> 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
> 	watch_devices(fd, 0x02, 0);
>
>      where in both cases, fd indicates the queue and the number after is a
>      tag between 0 and 255.
>
> (11) The watch must be removed if either the watch buffer is destroyed or
>      the watched object is destroyed.
>
>
> Things I want to avoid:
>
>  (1) Introducing features that make the core VFS dependent on the network
>      stack or networking namespaces (ie. usage of netlink).
>
>  (2) Dumping all this stuff into dmesg and having a daemon that sits there
>      parsing the output and distributing it as this then puts the
>      responsibility for security into userspace and makes handling
>      namespaces tricky.  Further, dmesg might not exist or might be
>      inaccessible inside a container.
>
>  (3) Letting users see events they shouldn't be able to see.
>
>
> The patches can be found here also:
>
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-core
>
> Changes:
>
>  ver #7:
>
>  (*) Removed the 'watch' argument from the security_watch_key() and
>      security_watch_devices() hooks as current_cred() can be used instead
>      of watch->cred.
>
>  ver #6:
>
>  (*) Fix mmap bug in watch_queue driver.
>
>  (*) Add an extended removal notification that can transmit an identifier
>      to userspace (such as a key ID).
>
>  (*) Don't produce a instantiation notification in mark_key_instantiated()
>      but rather do it in the caller to prevent key updates from producing
>      an instantiate notification as well as an update notification.
>
>  (*) Set the right number of filters in the sample program.
>
>  (*) Provide preliminary hook implementations for SELinux and Smack.
>
>  ver #5:
>
>  (*) Split the superblock watch and mount watch parts out into their own
>      branch (notifications-mount) as they really need certain fsinfo()
>      attributes.
>
>  (*) Rearrange the watch notification UAPI header to push the length down
>      to bits 0-5 and remove the lost-message bits.  The userspace's watch
>      ID tag is moved to bits 8-15 and then the message type is allocated
>      all of bits 16-31 for its own purposes.
>
>      The lost-message bit is moved over to the header, rather than being
>      placed in the next message to be generated and given its own word so
>      it can be cleared with xchg(,0) for parisc.
>
>  (*) The security_post_notification() hook is no longer called with the
>      spinlock held and softirqs disabled - though the RCU readlock is still
>      held.
>
>  (*) Buffer pages are now accounted towards RLIMIT_MEMLOCK and CAP_IPC_LOCK
>      will skip the overuse check.
>
>  (*) The buffer is marked VM_DONTEXPAND.
>
>  (*) Save the watch-setter's creds in struct watch and give that to the LSM
>      hook for posting a message.
>
>  ver #4:
>
>  (*) Split the basic UAPI bits out into their own patch and then split the
>      LSM hooks out into an intermediate patch.  Add LSM hooks for setting
>      watches.
>
>      Rename the *_notify() system calls to watch_*() for consistency.
>
>  ver #3:
>
>  (*) I've added a USB notification source and reformulated the block
>      notification source so that there's now a common watch list, for which
>      the system call is now device_notify().
>
>      I've assigned a pair of unused ioctl numbers in the 'W' series to the
>      ioctls added by this series.
>
>      I've also added a description of the kernel API to the documentation.
>
>  ver #2:
>
>  (*) I've fixed various issues raised by Jann Horn and GregKH and moved to
>      krefs for refcounting.  I've added some security features to try and
>      give Casey Schaufler the LSM control he wants.
>
> David
> ---
> David Howells (11):
>       uapi: General notification ring definitions
>       security: Add hooks to rule on setting a watch
>       security: Add a hook for the point of notification insertion
>       General notification queue with user mmap()'able ring buffer
>       keys: Add a notification facility
>       Add a general, global device notification watch list
>       block: Add block layer notifications
>       usb: Add USB subsystem notifications
>       Add sample notification program
>       selinux: Implement the watch_key security hook
>       smack: Implement the watch_key and post_notification hooks [untested]
>
>
>  Documentation/ioctl/ioctl-number.rst        |    1 
>  Documentation/security/keys/core.rst        |   58 ++
>  Documentation/watch_queue.rst               |  460 ++++++++++++++
>  arch/alpha/kernel/syscalls/syscall.tbl      |    1 
>  arch/arm/tools/syscall.tbl                  |    1 
>  arch/ia64/kernel/syscalls/syscall.tbl       |    1 
>  arch/m68k/kernel/syscalls/syscall.tbl       |    1 
>  arch/microblaze/kernel/syscalls/syscall.tbl |    1 
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
>  arch/parisc/kernel/syscalls/syscall.tbl     |    1 
>  arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
>  arch/s390/kernel/syscalls/syscall.tbl       |    1 
>  arch/sh/kernel/syscalls/syscall.tbl         |    1 
>  arch/sparc/kernel/syscalls/syscall.tbl      |    1 
>  arch/x86/entry/syscalls/syscall_32.tbl      |    1 
>  arch/x86/entry/syscalls/syscall_64.tbl      |    1 
>  arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
>  block/Kconfig                               |    9 
>  block/blk-core.c                            |   29 +
>  drivers/base/Kconfig                        |    9 
>  drivers/base/Makefile                       |    1 
>  drivers/base/watch.c                        |   90 +++
>  drivers/misc/Kconfig                        |   13 
>  drivers/misc/Makefile                       |    1 
>  drivers/misc/watch_queue.c                  |  893 +++++++++++++++++++++++++++
>  drivers/usb/core/Kconfig                    |    9 
>  drivers/usb/core/devio.c                    |   56 ++
>  drivers/usb/core/hub.c                      |    4 
>  include/linux/blkdev.h                      |   15 
>  include/linux/device.h                      |    7 
>  include/linux/key.h                         |    3 
>  include/linux/lsm_audit.h                   |    1 
>  include/linux/lsm_hooks.h                   |   38 +
>  include/linux/security.h                    |   32 +
>  include/linux/syscalls.h                    |    1 
>  include/linux/usb.h                         |   18 +
>  include/linux/watch_queue.h                 |   94 +++
>  include/uapi/asm-generic/unistd.h           |    4 
>  include/uapi/linux/keyctl.h                 |    2 
>  include/uapi/linux/watch_queue.h            |  183 ++++++
>  kernel/sys_ni.c                             |    1 
>  samples/Kconfig                             |    6 
>  samples/Makefile                            |    1 
>  samples/watch_queue/Makefile                |    8 
>  samples/watch_queue/watch_test.c            |  233 +++++++
>  security/keys/Kconfig                       |    9 
>  security/keys/compat.c                      |    3 
>  security/keys/gc.c                          |    5 
>  security/keys/internal.h                    |   30 +
>  security/keys/key.c                         |   38 +
>  security/keys/keyctl.c                      |   99 +++
>  security/keys/keyring.c                     |   20 -
>  security/keys/request_key.c                 |    4 
>  security/security.c                         |   23 +
>  security/selinux/hooks.c                    |   14 
>  security/smack/smack_lsm.c                  |   82 ++
>  58 files changed, 2593 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/watch_queue.rst
>  create mode 100644 drivers/base/watch.c
>  create mode 100644 drivers/misc/watch_queue.c
>  create mode 100644 include/linux/watch_queue.h
>  create mode 100644 include/uapi/linux/watch_queue.h
>  create mode 100644 samples/watch_queue/Makefile
>  create mode 100644 samples/watch_queue/watch_test.c
>
