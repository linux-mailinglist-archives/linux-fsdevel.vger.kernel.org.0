Return-Path: <linux-fsdevel+bounces-76072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HwWNBXmgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:59:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FBCFDD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23FAB30E5221
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C51938887D;
	Mon,  2 Feb 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdR2g8AT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4EB388867
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054640; cv=none; b=fbR2/YSkuu0muXnEmOkb/noZgfghjgMg3p5PcdZozHJfqZv4k7Tz+tfeCfTp2mnCWGT84Vwewa0a3/p2j0Xpvvxj/spxRiwiAF4/T68SALN001/v44MOwUgbB8BYb6RtIGsI4CgNRIbolW5JP/9/Pl54ekM9+6Y1kDXOxKTVd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054640; c=relaxed/simple;
	bh=1sO4SKx86mkHcoOMUXgtGHCRc6KnJdnIPMym5JQh9XY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=erqRkyVvymMWnV12g1swMUyV4oM7e/fx315ifBK2774lRTzwWok/pnVtRnqjfCyntca/loetwhjfYRteRkgTEDygoZQGCGyEQFH0VSULP1Gmtf+ii4aAWo6mm2hR6ge5eQFFvjHpJ9AKETTypirKgIj+dGvSoQUN/g+bhYPQCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdR2g8AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54177C4AF09;
	Mon,  2 Feb 2026 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770054640;
	bh=1sO4SKx86mkHcoOMUXgtGHCRc6KnJdnIPMym5JQh9XY=;
	h=Date:From:To:Cc:Subject:From;
	b=KdR2g8ATI5/bXDxYtVz6qOO4VHiY4CeNr6fr2pl+aCb5nQl/sM0caP2ZI0ImYOMLC
	 EX0u4UwSCtp0TrZ0htwoqggetW/4NeCszvfda50mvDcjMFaTDtD+EeAYqv/FdLrtTH
	 jBmJXRiFq8ncRaclMUNns22R64apj3bcxsVE0aqeBgLrHPsw2ng7KZri+XnnsgkH3M
	 HTkb3sSFv/iij0e+UMwDlwg9Isx6WONwhKgiSjIWzhB9wNJHyhB9omPUI044WqzfcH
	 bobYUIgtdU91jTZZw/o5Y2ytU0DWCCZirTP03s2U0K1UFHT5tcpRxzehJLwEng1nxe
	 WeCG5R/BjP9QA==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51B67F40069;
	Mon,  2 Feb 2026 12:50:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 02 Feb 2026 12:50:39 -0500
X-ME-Sender: <xms:7-OAaYZxzeFyZP9fOQN03vJkJHuozO4bimEtg7nx2iL_Yn6fxablaA>
    <xme:7-OAacJVKDHr3xRyTm8tULuhm-zvdnyyPnIpqC-Nku7Mk39xl29zEXskJo-mfjDN8
    Hr-bgX_95XSGMbCUMPrRD7wxm02rOzRrNvwewzgZDcKBk4WRhWuHQ>
X-ME-Received: <xmr:7-OAaRrvr8Cd_loyMoHZcJrzG-epcWax6CNYhy2FKGvKpIdn-5kNLt-Nc11Q0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkgggtugesmhdtreertddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvdevudegkedvgfffjeejteejueektedttdekkefhtdeuveeliedvudevgefgvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilh
    hlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheehqddv
    keeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrg
    hmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrg
    hunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
    pdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggroh
    hlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7-OAaVDBzHX41GcX-OlD7tAtq4go3k2hxzu05NMsvnw6drCXK0hCPw>
    <xmx:7-OAaXfuUk8M-Hq0Gwa0T6aFjlkkS4rl-r4FrgFamN3_lQKMLY_KEQ>
    <xmx:7-OAaVIpOVSxuwbLH3YEJRATTyovgLc3whHimPHemdcaUchgAWhgSA>
    <xmx:7-OAaXtNtIDXl4x3ykYRUVQVDsiEHuQKg5m7Xlf1755O8flCKYEI4g>
    <xmx:7-OAafbcqPb7IztY10j8byc90_YJ7U8S46VALWIeLba52O5z_qDvHxEF>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 12:50:37 -0500 (EST)
Date: Mon, 2 Feb 2026 17:50:30 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Orphan filesystems after mount namespace destruction and tmpfs "leak"
Message-ID: <aYDjHJstnz2V-ZZg@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="odh3srnjw53gxerh"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_UNKNOWN(0.10)[application/x-sh];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76072-lists,linux-fsdevel=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monitor_tmpfs.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A5FBCFDD5
X-Rspamd-Action: no action


--odh3srnjw53gxerh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In the Meta fleet, we saw a problem where destroying a container didn't
lead to freeing the shmem memory attributed to a tmpfs mounted inside
that container. It triggered an OOM when a new container attempted to
start.

Investigation has shown that this happened because a process outside of
the container kept a file from the tmpfs mapped. The mapped file is
small (4k), but it holds all the contents of the tmpfs (~47GiB) from
being freed.

When a tmpfs filesystem is mounted inside a mount namespace (e.g., a
container), and a process outside that namespace holds an open file
descriptor to a file on that tmpfs, the tmpfs superblock remains in
kernel memory indefinitely after:

1. All processes inside the mount namespace have exited.
2. The mount namespace has been destroyed.
3. The tmpfs is no longer visible in any mount namespace.

The superblock persists with mnt_ns = NULL in its mount structures,
keeping all tmpfs contents pinned in memory until the external file
descriptor is closed.

The problem is not specific to tmpfs, but for filesystems with backing
storage, the memory impact is not as severe since the page cache is
reclaimable.

The obvious solution to the problem is "Don't do that": the file should
be unmapped/closed upon container destruction.

But I wonder if the kernel can/should do better here? Currently, this
scenario is hard to diagnose. It looks like a leak of shmem pages.

Also, I wonder if the current behavior can lead to data loss on a
filesystem with backing storage:
 - The mount namespace where my USB stick was mounted is gone.
 - The USB stick is no longer mounted anywhere.
 - I can pull the USB stick out.
 - Oops, someone was writing there: corruption/data loss.

I am not sure what a possible solution would be here. I can only think
of blocking exit(2) for the last process in the namespace until all
filesystems are cleanly unmounted, but that is not very informative
either.

I have attached a Claude-generated reproducer and a drgn script that
lists orphan tmpfs filesystems.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

--odh3srnjw53gxerh
Content-Type: application/x-sh
Content-Disposition: attachment; filename="tmpfs_leak_reproducer.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A# Reproducer for tmpfs leak via external file descriptor=0A#=
=0A# Scenario:=0A# 1. Create a "container" (new mount namespace) with a tmp=
fs=0A# 2. Create a file on the tmpfs=0A# 3. Process outside the container o=
pens the file via /proc/<pid>/root/...=0A# 4. Container (mount namespace) i=
s destroyed=0A# 5. tmpfs remains alive because external process holds a ref=
erence=0A=0Aset -e=0A=0AWORKDIR=3D"/tmp/tmpfs_leak_test_$$"=0Amkdir -p "$WO=
RKDIR"=0A=0Acleanup() {=0A    echo "[cleanup] Cleaning up..."=0A    # Close=
 FD 3 if still open=0A    exec 3<&- 2>/dev/null || true=0A    jobs -p | xar=
gs -r kill 2>/dev/null || true=0A    rm -rf "$WORKDIR" 2>/dev/null || true=
=0A}=0Atrap cleanup EXIT=0A=0Aecho "=3D=3D=3D tmpfs Leak Reproducer (Shell =
Version) =3D=3D=3D"=0Aecho ""=0Aecho "This demonstrates how an external pro=
cess holding a file descriptor"=0Aecho "to a file inside a container's tmpf=
s can prevent container cleanup."=0Aecho ""=0A=0A# Step 1: Create a "contai=
ner" process in a new mount namespace=0Aecho "[1] Creating container with n=
ew mount namespace and tmpfs..."=0A=0A# Create a pipe for synchronization=
=0Amkfifo "$WORKDIR/container_ready"=0Amkfifo "$WORKDIR/external_ready"=0A=
=0Aunshare --mount --fork bash -c '=0A    WORKDIR=3D"'"$WORKDIR"'"=0A    ec=
ho "[container] PID: $$"=0A    # Make mount namespace private=0A    mount -=
-make-rprivate /=0A    # Create and mount tmpfs=0A    mkdir -p /tmp/contain=
er_tmpfs=0A    mount -t tmpfs -o size=3D10M tmpfs_device /tmp/container_tmp=
fs=0A    # Create a file on the tmpfs=0A    echo "Secret container data - P=
ID $$" > /tmp/container_tmpfs/secret_file.txt=0A    echo "[container] tmpfs=
 mounted at /tmp/container_tmpfs"=0A    echo "[container] Created /tmp/cont=
ainer_tmpfs/secret_file.txt"=0A    # Signal ready (write to pipe)=0A    ech=
o "ready" > "$WORKDIR/container_ready"=0A    echo "[container] Waiting for =
external process to grab FD..."=0A    # Wait for external process (read fro=
m pipe blocks until written)=0A    read _ < "$WORKDIR/external_ready"=0A   =
 echo "[container] External process has FD. Exiting in 2 seconds..."=0A    =
sleep 2=0A    echo "[container] Exiting now - mount namespace will be destr=
oyed"=0A' &=0A=0ACONTAINER_PID=3D$!=0Aecho "[main] Container shell PID: $CO=
NTAINER_PID"=0A=0A# Wait for container to be ready=0Aecho "[2] Waiting for =
container to set up tmpfs..."=0Aread _ < "$WORKDIR/container_ready"=0Aecho =
"[+] Container is ready"=0A=0A# Find the actual unshare child process=0Asle=
ep 0.5=0ACHILD_PID=3D$(pgrep -P $CONTAINER_PID 2>/dev/null | head -1)=0Aif =
[ -z "$CHILD_PID" ]; then=0A    CHILD_PID=3D$CONTAINER_PID=0Afi=0Aecho "[+]=
 Container process PID: $CHILD_PID"=0A=0A# Step 2: External process opens f=
ile via /proc/<pid>/root=0Aecho ""=0Aecho "[3] External process opening fil=
e from container's tmpfs..."=0A=0APROC_PATH=3D"/proc/$CHILD_PID/root/tmp/co=
ntainer_tmpfs/secret_file.txt"=0A=0Aif [ ! -f "$PROC_PATH" ]; then=0A    ec=
ho "[!] Cannot find file at $PROC_PATH"=0A    echo "[!] Trying with contain=
er shell PID..."=0A    PROC_PATH=3D"/proc/$CONTAINER_PID/root/tmp/container=
_tmpfs/secret_file.txt"=0Afi=0A=0A# Open the file and keep it open - save c=
ontent for later=0Aexec 3< "$PROC_PATH"=0AORIGINAL_CONTENT=3D$(cat <&3)=0Ae=
cho "[external] Opened FD 3 to: $PROC_PATH"=0Aecho "[external] File content=
s: $ORIGINAL_CONTENT"=0A=0A# Signal container we have the FD=0Aecho "ready"=
 > "$WORKDIR/external_ready"=0Aecho "[external] Signaled container"=0A=0A# =
Wait for container to exit=0Aecho "[external] Waiting for container to exit=
=2E.."=0Await $CONTAINER_PID 2>/dev/null || true=0A=0Aecho ""=0Aecho "=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"=0Aecho "[exte=
rnal] CONTAINER HAS EXITED!"=0Aecho "[external] Mount namespace should be d=
estroyed"=0Aecho "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"=0Aecho ""=0A=0A# Show we still have access - use /proc/self/fd/3 to=
 read=0Aecho "[external] But we still have FD 3 open!"=0Aecho "[external] R=
eading via /proc/self/fd/3:"=0Acat /proc/self/fd/3 2>/dev/null || echo "(re=
ad failed - but FD still holds reference)"=0A=0Aecho ""=0Aecho "[external] =
FD 3 details:"=0Als -la /proc/self/fd/3 2>/dev/null || echo "(fd info not a=
vailable)"=0Areadlink /proc/self/fd/3 2>/dev/null || echo "(target path - n=
ote it's a deleted/orphaned file)"=0A=0Aecho ""=0Aecho "[external] The tmpf=
s superblock remains in kernel memory!"=0Aecho "[external] Even though the =
mount namespace is gone, the superblock persists"=0Aecho "[external] becaus=
e we hold a file reference."=0Aecho ""=0Aecho "[external] Holding FD for 10=
 seconds to allow inspection..."=0Aecho ""=0Aecho "You can check with: sudo=
 drgn monitor_tmpfs.py"=0Aecho ""=0A=0Asleep 10=0A=0Aecho "[external] Closi=
ng FD 3..."=0Aexec 3<&-=0A=0Aecho "[external] Done. tmpfs superblock should=
 now be freed."=0Aecho ""=0Aecho "=3D=3D=3D Reproducer Complete =3D=3D=3D"=
=0A
--odh3srnjw53gxerh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="monitor_tmpfs.py"

#!/usr/bin/env drgn
"""
Monitor tmpfs superblocks to detect orphaned/leaked tmpfs filesystems.

Run with: sudo drgn -s /path/to/vmlinux monitor_tmpfs.py

This script lists all tmpfs superblocks and shows which ones have
NULL mount namespaces (orphaned) or are otherwise in unusual states.
"""

from drgn import container_of
from drgn.helpers.linux.list import hlist_for_each_entry, list_for_each_entry

def get_mount_info(sb):
    """Get mount information for a superblock"""
    mounts = []
    try:
        for mnt in list_for_each_entry('struct mount', sb.s_mounts.address_of_(), 'mnt_instance'):
            try:
                mnt_ns = mnt.mnt_ns
                mnt_ns_addr = mnt_ns.value_() if mnt_ns else 0

                # Get device name
                devname = mnt.mnt_devname.string_().decode('utf-8', errors='replace') if mnt.mnt_devname else "?"

                # Get mount point
                mnt_mountpoint = mnt.mnt_mountpoint
                if mnt_mountpoint:
                    name = mnt_mountpoint.d_name.name.string_().decode('utf-8', errors='replace')
                else:
                    name = "?"

                mounts.append({
                    'mnt_ns': mnt_ns_addr,
                    'devname': devname,
                    'mountpoint': name,
                    'mnt_addr': mnt.value_()
                })
            except:
                continue
    except:
        pass
    return mounts


def main():
    # Get the tmpfs/shmem filesystem type
    shmem_fs_type = prog['shmem_fs_type']

    print("=" * 80)
    print("tmpfs Superblock Monitor")
    print("=" * 80)
    print()

    # Collect all tmpfs superblocks
    tmpfs_sbs = []
    for sb in hlist_for_each_entry('struct super_block', shmem_fs_type.fs_supers, 's_instances'):
        tmpfs_sbs.append(sb)

    print(f"Found {len(tmpfs_sbs)} tmpfs superblocks\n")

    orphaned = []
    normal = []

    for sb in tmpfs_sbs:
        sb_addr = sb.value_()
        s_dev = sb.s_dev.value_()
        s_active = sb.s_active.counter.value_()

        mounts = get_mount_info(sb)

        # Check if any mount has NULL namespace
        has_orphaned = any(m['mnt_ns'] == 0 for m in mounts)
        has_normal = any(m['mnt_ns'] != 0 for m in mounts)

        info = {
            'sb': sb,
            'sb_addr': sb_addr,
            's_dev': s_dev,
            's_active': s_active,
            'mounts': mounts,
            'has_orphaned': has_orphaned
        }

        if has_orphaned and not has_normal:
            orphaned.append(info)
        else:
            normal.append(info)

    # Print orphaned superblocks first (these are the leaked ones)
    if orphaned:
        print("!!! ORPHANED tmpfs SUPERBLOCKS (potential leaks) !!!")
        print("-" * 80)
        for info in orphaned:
            sb = info['sb']
            print(f"Superblock: 0x{info['sb_addr']:016x}")
            print(f"  s_dev: {info['s_dev']}")
            print(f"  s_active: {info['s_active']}")

            # Try to list some files
            try:
                root = sb.s_root
                if root:
                    print("  Root dentry contents:")
                    count = 0
                    for child in hlist_for_each_entry('struct dentry', root.d_children, 'd_sib'):
                        name = child.d_name.name.string_().decode('utf-8', errors='replace')
                        inode = child.d_inode
                        if inode:
                            size = inode.i_size.value_()
                            print(f"    - {name} ({size} bytes)")
                            count += 1
                            if count >= 10:
                                print("    ... (more files)")
                                break
            except Exception as e:
                print(f"  Error listing files: {e}")

            for m in info['mounts']:
                print(f"  Mount: {m['devname']} -> {m['mountpoint']}")
                print(f"         mnt_ns: 0x{m['mnt_ns']:016x} (NULL = orphaned)")
            print()
        print()

    # Print summary of normal superblocks
    print("Normal tmpfs superblocks:")
    print("-" * 80)
    for info in normal:
        devnames = set(m['devname'] for m in info['mounts'])
        namespaces = set(m['mnt_ns'] for m in info['mounts'])
        print(f"0x{info['sb_addr']:016x} s_dev={info['s_dev']:<4} "
              f"active={info['s_active']:<3} "
              f"mounts={len(info['mounts']):<3} "
              f"devnames={devnames}")

    print()
    print("=" * 80)
    print(f"Summary: {len(orphaned)} orphaned, {len(normal)} normal")
    if orphaned:
        print("WARNING: Orphaned tmpfs superblocks detected - these may be leaking memory!")
    print("=" * 80)


if __name__ == "__main__":
    main()

--odh3srnjw53gxerh--

