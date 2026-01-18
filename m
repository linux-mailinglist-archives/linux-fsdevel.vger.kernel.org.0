Return-Path: <linux-fsdevel+bounces-74350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F16D39AE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D67130428E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8730EF9B;
	Sun, 18 Jan 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="lkBa2wR0";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="rx+4lLV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-78.smtp-out.amazonses.com (a11-78.smtp-out.amazonses.com [54.240.11.78])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884329BD8E;
	Sun, 18 Jan 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775811; cv=none; b=q/w1niUgXc+Ms+r/8aBTgvFJbW09xmYMffcM4J6HsDHop8CGP2TrplVp9aOPGObHpXIvbVeqVvdBfKX96aDowLSlpAPph67cB8WZRDPQcIRNxXOZt4zcqGJxAly0VyvKnhuGp/DhIlLPrNJ7KcZzr/Za3NbyNHfyYVTqUd4OB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775811; c=relaxed/simple;
	bh=JllOgEM7aQKk+PtcWXrB+BYsUOTL+sv45IkCgmrJnLk=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=qZpNFu4ofK1yD4T/wJ1T45NzllN16yd//QMsY9tDbCAylVl+Z8ub/jYdSH43woLsP8EBSM0KVgDirIBf0f+h/m8Re6SlOM4TEAO+zfezQ8M6ZaUNgQgFjqQyZPgPl88A1NEZkusTg85ssWGa/5X7dccgDczSCdVBsYjnE+2+5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=lkBa2wR0; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=rx+4lLV/; arc=none smtp.client-ip=54.240.11.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775809;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=JllOgEM7aQKk+PtcWXrB+BYsUOTL+sv45IkCgmrJnLk=;
	b=lkBa2wR0c1KJ6tYMBmA4O7tNVXthnwHBN0IYp9/mbdT6jkOOT97okdIqgaN4i5mh
	yBnVJl7SemZSlBerfWeLaevsIyBSUk5L0WB8FOsn5Zw9gDmGMm1CPWEQuSvpoJmvWg8
	iHGs5dSCOY6ZcKVgxFDPwimczokf65LtqaV5QH5o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775809;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=JllOgEM7aQKk+PtcWXrB+BYsUOTL+sv45IkCgmrJnLk=;
	b=rx+4lLV//cYIJdtTI61sCGwwf3jnZ9eDLG2dC2cEa+gE59duLovbxQ9/NV9Ir6fb
	+Ddqw7xfJSJCe6e0XBA8SJsBnKlD8rA1YRTWKEm0FrZL3CfJoBd+k2p/0pRjLATzgqW
	+Yw/NBgRGIYxJh8j/RbuTlatPlbU26rH3uyV1Ufs=
Subject: [PATCH V4 2/2] Add test/daxctl-famfs.sh to test famfs mode
 transitions:
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:36:48 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
References: 
 <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com> 
 <20260118223640.92878-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMrtvo3ZFLchSiSa1LQKlwQxpg==
Thread-Topic: [PATCH V4 2/2] Add test/daxctl-famfs.sh to test famfs mode
 transitions:
X-Wm-Sent-Timestamp: 1768775807
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd340f73c-90b0fafb-786e-4368-85f0-149ffa1d637a-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.78

From: John Groves <John@Groves.net>=0D=0A=0D=0A- devdax <-> famfs mode sw=
itches=0D=0A- Verify famfs -> system-ram is rejected (must go via devdax)=
=0D=0A- Test JSON output shows correct mode=0D=0A- Test error handling fo=
r invalid modes=0D=0A=0D=0AThe test is added to the destructive test suit=
e since it=0D=0Amodifies device modes.=0D=0A=0D=0ASigned-off-by: John Gro=
ves <john@groves.net>=0D=0A---=0D=0A test/daxctl-famfs.sh | 253 +++++++++=
++++++++++++++++++++++++++++++++++=0D=0A test/meson.build     |   2 +=0D=0A=
 2 files changed, 255 insertions(+)=0D=0A create mode 100755 test/daxctl-=
famfs.sh=0D=0A=0D=0Adiff --git a/test/daxctl-famfs.sh b/test/daxctl-famfs=
=2Esh=0D=0Anew file mode 100755=0D=0Aindex 0000000..12fbfef=0D=0A--- /dev=
/null=0D=0A+++ b/test/daxctl-famfs.sh=0D=0A@@ -0,0 +1,253 @@=0D=0A+#!/bin=
/bash -Ex=0D=0A+# SPDX-License-Identifier: GPL-2.0=0D=0A+# Copyright (C) =
2025 Micron Technology, Inc. All rights reserved.=0D=0A+#=0D=0A+# Test da=
xctl famfs mode transitions and mode detection=0D=0A+=0D=0A+rc=3D77=0D=0A=
+. $(dirname $0)/common=0D=0A+=0D=0A+trap 'cleanup $LINENO' ERR=0D=0A+=0D=
=0A+daxdev=3D""=0D=0A+original_mode=3D""=0D=0A+=0D=0A+cleanup()=0D=0A+{=0D=
=0A+=09printf "Error at line %d\n" "$1"=0D=0A+=09# Try to restore to orig=
inal mode if we know it=0D=0A+=09if [[ $daxdev && $original_mode ]]; then=
=0D=0A+=09=09"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev=
" 2>/dev/null || true=0D=0A+=09fi=0D=0A+=09exit $rc=0D=0A+}=0D=0A+=0D=0A+=
# Check if fsdev_dax module is available=0D=0A+check_fsdev_dax()=0D=0A+{=0D=
=0A+=09if modinfo fsdev_dax &>/dev/null; then=0D=0A+=09=09return 0=0D=0A+=
=09fi=0D=0A+=09if grep -qF "fsdev_dax" "/lib/modules/$(uname -r)/modules.=
builtin" 2>/dev/null; then=0D=0A+=09=09return 0=0D=0A+=09fi=0D=0A+=09prin=
tf "fsdev_dax module not available, skipping\n"=0D=0A+=09exit 77=0D=0A+}=0D=
=0A+=0D=0A+# Check if kmem module is available (needed for system-ram mod=
e tests)=0D=0A+check_kmem()=0D=0A+{=0D=0A+=09if modinfo kmem &>/dev/null;=
 then=0D=0A+=09=09return 0=0D=0A+=09fi=0D=0A+=09if grep -qF "kmem" "/lib/=
modules/$(uname -r)/modules.builtin" 2>/dev/null; then=0D=0A+=09=09return=
 0=0D=0A+=09fi=0D=0A+=09printf "kmem module not available, skipping syste=
m-ram tests\n"=0D=0A+=09return 1=0D=0A+}=0D=0A+=0D=0A+# Find an existing =
dax device to test with=0D=0A+find_daxdev()=0D=0A+{=0D=0A+=09# Look for a=
ny available dax device=0D=0A+=09daxdev=3D$("$DAXCTL" list | jq -er '.[0]=
=2Echardev // empty' 2>/dev/null) || true=0D=0A+=0D=0A+=09if [[ ! $daxdev=
 ]]; then=0D=0A+=09=09printf "No dax device found, skipping\n"=0D=0A+=09=09=
exit 77=0D=0A+=09fi=0D=0A+=0D=0A+=09# Save the original mode so we can re=
store it=0D=0A+=09original_mode=3D$("$DAXCTL" list -d "$daxdev" | jq -er =
'.[].mode')=0D=0A+=0D=0A+=09printf "Found dax device: %s (current mode: %=
s)\n" "$daxdev" "$original_mode"=0D=0A+}=0D=0A+=0D=0A+daxctl_get_mode()=0D=
=0A+{=0D=0A+=09"$DAXCTL" list -d "$1" | jq -er '.[].mode'=0D=0A+}=0D=0A+=0D=
=0A+# Ensure device is in devdax mode for testing=0D=0A+ensure_devdax_mod=
e()=0D=0A+{=0D=0A+=09local mode=0D=0A+=09mode=3D$(daxctl_get_mode "$daxde=
v")=0D=0A+=0D=0A+=09if [[ "$mode" =3D=3D "devdax" ]]; then=0D=0A+=09=09re=
turn 0=0D=0A+=09fi=0D=0A+=0D=0A+=09if [[ "$mode" =3D=3D "system-ram" ]]; =
then=0D=0A+=09=09printf "Device is in system-ram mode, attempting to conv=
ert to devdax...\n"=0D=0A+=09=09"$DAXCTL" reconfigure-device -f -m devdax=
 "$daxdev"=0D=0A+=09elif [[ "$mode" =3D=3D "famfs" ]]; then=0D=0A+=09=09p=
rintf "Device is in famfs mode, converting to devdax...\n"=0D=0A+=09=09"$=
DAXCTL" reconfigure-device -m devdax "$daxdev"=0D=0A+=09else=0D=0A+=09=09=
printf "Device is in unknown mode: %s\n" "$mode"=0D=0A+=09=09return 1=0D=0A=
+=09fi=0D=0A+=0D=0A+=09[[ $(daxctl_get_mode "$daxdev") =3D=3D "devdax" ]]=
=0D=0A+}=0D=0A+=0D=0A+#=0D=0A+# Test basic mode transitions involving fam=
fs=0D=0A+#=0D=0A+test_famfs_mode_transitions()=0D=0A+{=0D=0A+=09printf "\=
n=3D=3D=3D Testing famfs mode transitions =3D=3D=3D\n"=0D=0A+=0D=0A+=09# =
Ensure starting in devdax mode=0D=0A+=09ensure_devdax_mode=0D=0A+=09[[ $(=
daxctl_get_mode "$daxdev") =3D=3D "devdax" ]]=0D=0A+=09printf "Initial mo=
de: devdax - OK\n"=0D=0A+=0D=0A+=09# Test: devdax -> famfs=0D=0A+=09print=
f "Testing devdax -> famfs... "=0D=0A+=09"$DAXCTL" reconfigure-device -m =
famfs "$daxdev"=0D=0A+=09[[ $(daxctl_get_mode "$daxdev") =3D=3D "famfs" ]=
]=0D=0A+=09printf "OK\n"=0D=0A+=0D=0A+=09# Test: famfs -> famfs (re-enabl=
e in same mode)=0D=0A+=09printf "Testing famfs -> famfs (re-enable)... "=0D=
=0A+=09"$DAXCTL" reconfigure-device -m famfs "$daxdev"=0D=0A+=09[[ $(daxc=
tl_get_mode "$daxdev") =3D=3D "famfs" ]]=0D=0A+=09printf "OK\n"=0D=0A+=0D=
=0A+=09# Test: famfs -> devdax=0D=0A+=09printf "Testing famfs -> devdax..=
=2E "=0D=0A+=09"$DAXCTL" reconfigure-device -m devdax "$daxdev"=0D=0A+=09=
[[ $(daxctl_get_mode "$daxdev") =3D=3D "devdax" ]]=0D=0A+=09printf "OK\n"=
=0D=0A+=0D=0A+=09# Test: devdax -> devdax (re-enable in same mode)=0D=0A+=
=09printf "Testing devdax -> devdax (re-enable)... "=0D=0A+=09"$DAXCTL" r=
econfigure-device -m devdax "$daxdev"=0D=0A+=09[[ $(daxctl_get_mode "$dax=
dev") =3D=3D "devdax" ]]=0D=0A+=09printf "OK\n"=0D=0A+}=0D=0A+=0D=0A+#=0D=
=0A+# Test mode transitions with system-ram (requires kmem)=0D=0A+#=0D=0A=
+test_system_ram_transitions()=0D=0A+{=0D=0A+=09printf "\n=3D=3D=3D Testi=
ng system-ram transitions with famfs =3D=3D=3D\n"=0D=0A+=0D=0A+=09# Ensur=
e we start in devdax mode=0D=0A+=09ensure_devdax_mode=0D=0A+=09[[ $(daxct=
l_get_mode "$daxdev") =3D=3D "devdax" ]]=0D=0A+=0D=0A+=09# Test: devdax -=
> system-ram=0D=0A+=09printf "Testing devdax -> system-ram... "=0D=0A+=09=
"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"=0D=0A+=09[[ $(dax=
ctl_get_mode "$daxdev") =3D=3D "system-ram" ]]=0D=0A+=09printf "OK\n"=0D=0A=
+=0D=0A+=09# Test: system-ram -> famfs should fail=0D=0A+=09printf "Testi=
ng system-ram -> famfs (should fail)... "=0D=0A+=09if "$DAXCTL" reconfigu=
re-device -m famfs "$daxdev" 2>/dev/null; then=0D=0A+=09=09printf "FAILED=
 - should have been rejected\n"=0D=0A+=09=09return 1=0D=0A+=09fi=0D=0A+=09=
printf "OK (correctly rejected)\n"=0D=0A+=0D=0A+=09# Test: system-ram -> =
devdax -> famfs (proper path)=0D=0A+=09printf "Testing system-ram -> devd=
ax -> famfs... "=0D=0A+=09"$DAXCTL" reconfigure-device -f -m devdax "$dax=
dev"=0D=0A+=09[[ $(daxctl_get_mode "$daxdev") =3D=3D "devdax" ]]=0D=0A+=09=
"$DAXCTL" reconfigure-device -m famfs "$daxdev"=0D=0A+=09[[ $(daxctl_get_=
mode "$daxdev") =3D=3D "famfs" ]]=0D=0A+=09printf "OK\n"=0D=0A+=0D=0A+=09=
# Restore to devdax for subsequent tests=0D=0A+=09"$DAXCTL" reconfigure-d=
evice -m devdax "$daxdev"=0D=0A+}=0D=0A+=0D=0A+#=0D=0A+# Test JSON output=
 shows correct mode=0D=0A+#=0D=0A+test_json_output()=0D=0A+{=0D=0A+=09pri=
ntf "\n=3D=3D=3D Testing JSON output for mode field =3D=3D=3D\n"=0D=0A+=0D=
=0A+=09# Test devdax mode in JSON=0D=0A+=09ensure_devdax_mode=0D=0A+=09pr=
intf "Testing JSON output for devdax mode... "=0D=0A+=09mode=3D$("$DAXCTL=
" list -d "$daxdev" | jq -er '.[].mode')=0D=0A+=09[[ "$mode" =3D=3D "devd=
ax" ]]=0D=0A+=09printf "OK\n"=0D=0A+=0D=0A+=09# Test famfs mode in JSON=0D=
=0A+=09"$DAXCTL" reconfigure-device -m famfs "$daxdev"=0D=0A+=09printf "T=
esting JSON output for famfs mode... "=0D=0A+=09mode=3D$("$DAXCTL" list -=
d "$daxdev" | jq -er '.[].mode')=0D=0A+=09[[ "$mode" =3D=3D "famfs" ]]=0D=
=0A+=09printf "OK\n"=0D=0A+=0D=0A+=09# Restore to devdax=0D=0A+=09"$DAXCT=
L" reconfigure-device -m devdax "$daxdev"=0D=0A+}=0D=0A+=0D=0A+#=0D=0A+# =
Test error messages for invalid transitions=0D=0A+#=0D=0A+test_error_hand=
ling()=0D=0A+{=0D=0A+=09printf "\n=3D=3D=3D Testing error handling =3D=3D=
=3D\n"=0D=0A+=0D=0A+=09# Ensure we're in famfs mode=0D=0A+=09"$DAXCTL" re=
configure-device -m famfs "$daxdev"=0D=0A+=0D=0A+=09# Test that invalid m=
ode is rejected=0D=0A+=09printf "Testing invalid mode rejection... "=0D=0A=
+=09if "$DAXCTL" reconfigure-device -m invalidmode "$daxdev" 2>/dev/null;=
 then=0D=0A+=09=09printf "FAILED - invalid mode should be rejected\n"=0D=0A=
+=09=09return 1=0D=0A+=09fi=0D=0A+=09printf "OK (correctly rejected)\n"=0D=
=0A+=0D=0A+=09# Restore to devdax=0D=0A+=09"$DAXCTL" reconfigure-device -=
m devdax "$daxdev"=0D=0A+}=0D=0A+=0D=0A+#=0D=0A+# Main test sequence=0D=0A=
+#=0D=0A+main()=0D=0A+{=0D=0A+=09check_fsdev_dax=0D=0A+=09find_daxdev=0D=0A=
+=0D=0A+=09rc=3D1  # From here on, failures are real failures=0D=0A+=0D=0A=
+=09test_famfs_mode_transitions=0D=0A+=09test_json_output=0D=0A+=09test_e=
rror_handling=0D=0A+=0D=0A+=09# System-ram tests require kmem module=0D=0A=
+=09if check_kmem; then=0D=0A+=09=09# Save and disable online policy for =
system-ram tests=0D=0A+=09=09saved_policy=3D"$(cat /sys/devices/system/me=
mory/auto_online_blocks)"=0D=0A+=09=09echo "offline" > /sys/devices/syste=
m/memory/auto_online_blocks=0D=0A+=0D=0A+=09=09test_system_ram_transition=
s=0D=0A+=0D=0A+=09=09# Restore online policy=0D=0A+=09=09echo "$saved_pol=
icy" > /sys/devices/system/memory/auto_online_blocks=0D=0A+=09fi=0D=0A+=0D=
=0A+=09# Restore original mode=0D=0A+=09printf "\nRestoring device to ori=
ginal mode: %s\n" "$original_mode"=0D=0A+=09"$DAXCTL" reconfigure-device =
-f -m "$original_mode" "$daxdev"=0D=0A+=0D=0A+=09printf "\n=3D=3D=3D All =
famfs tests passed =3D=3D=3D\n"=0D=0A+=0D=0A+=09exit 0=0D=0A+}=0D=0A+=0D=0A=
+main=0D=0Adiff --git a/test/meson.build b/test/meson.build=0D=0Aindex 61=
5376e..ad1d393 100644=0D=0A--- a/test/meson.build=0D=0A+++ b/test/meson.b=
uild=0D=0A@@ -209,6 +209,7 @@ if get_option('destructive').enabled()=0D=0A=
   device_dax_fio =3D find_program('device-dax-fio.sh')=0D=0A   daxctl_de=
vices =3D find_program('daxctl-devices.sh')=0D=0A   daxctl_create =3D fin=
d_program('daxctl-create.sh')=0D=0A+  daxctl_famfs =3D find_program('daxc=
tl-famfs.sh')=0D=0A   dm =3D find_program('dm.sh')=0D=0A   mmap_test =3D =
find_program('mmap.sh')=0D=0A=20=0D=0A@@ -226,6 +227,7 @@ if get_option('=
destructive').enabled()=0D=0A     [ 'device-dax-fio.sh', device_dax_fio, =
'dax'   ],=0D=0A     [ 'daxctl-devices.sh', daxctl_devices, 'dax'   ],=0D=
=0A     [ 'daxctl-create.sh',  daxctl_create,  'dax'   ],=0D=0A+    [ 'da=
xctl-famfs.sh',   daxctl_famfs,   'dax'   ],=0D=0A     [ 'dm.sh',        =
     dm,=09=09   'dax'   ],=0D=0A     [ 'mmap.sh',           mmap_test,=09=
   'dax'   ],=0D=0A   ]=0D=0A--=20=0D=0A2.49.0=0D=0A=0D=0A

