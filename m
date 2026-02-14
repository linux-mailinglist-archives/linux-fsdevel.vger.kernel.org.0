Return-Path: <linux-fsdevel+bounces-77209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EApGQVvkGk8ZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:48:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5F13BF54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF15A301FD6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73281C862F;
	Sat, 14 Feb 2026 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOpZWWQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB67081F
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771073279; cv=pass; b=sjQO8ewRxCE7sxjF7CcQMgCG84s1dmSRBfnli6vafhtViFITxPS05geeQwGuoTcuaVTibdmTwmY+nG8ZBFAI0cRFiHfG4wrJ1OAF1FSRM7BxPX38i8+qO/nhHTuYGZjvdAJesl4R6Ke70/P9fAEHNJeu0GXRTBC2rBbb4kGbjJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771073279; c=relaxed/simple;
	bh=MZbQTn7Oc+cYI5yLnL9iTgmtw30rZo29tAy2Ra33lMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iwubYSLJJEF0H7NaIdb8kLg7EkY0Sh/RsnQf3/RpNCiOlprTBkoaEPQ8EcFK5f3+5cTFUd7kOqRe3HWK34T7k5MIhWzeuge6oGMTR85Dys5n52drkzot1980Lr00gbEtcAnDa5D4Ih+0cJEHwJ4GhErHnh/dKkTnM0ijTnTY5m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOpZWWQR; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d1872504cbso1676537a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 04:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771073276; cv=none;
        d=google.com; s=arc-20240605;
        b=ggzPMp51bEVAT5+F4Q+5VqeV4WRlaRpsDrIjm1ZZb4ALs4etNfQN9lI8vnQ1MeCNbk
         Ns60Rkhhj7o41Zy5pg0sxPq33zdjc3FqzMts4NL4GbHOBIATs20Y1o9ha70RPGoL6Quy
         feBLgzYc4gdguLucxog+nb7U7V9IDlcX/PJBCfB5RIdQwd886mEl9BLc45L9yiJdurZD
         g5GUZ70moUpZnCLr4XNYjhbUZA4gMCKRJYQpguvJKRuWQ5jUcGC162pdaqns/IZcVJFB
         Wu44Ykk3g24PiBqV5fVrlKId/7eTi8FO2lwH7pLWMJWh5IwjOEyBhfOogS54NZhVsiCf
         8PcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xrY9u9fHg6HZdNm0UxLibzOXJWbdwIZ87YpvvsX2F8Q=;
        fh=bSBpEsngLpaVqjJywRVLnceI2UV5IkVafH3EN69EvMQ=;
        b=FUq3VjW3cE6fqsmdkOPJAslUTzjFeT9JdZ9wYRtZmF6XjOCqBl0mOO1bPtU92oHvgD
         roD2VA6/USESB86Tj4aYByHcblEiN44Ig+o6UWZ+vNnYLKQWZSXVzKxieChuz7V6Wz43
         WSL74tpLgq5SVj8effxfN4fa7i88w0H4pInIfep1/K+6zqUF+QSRsGaSSDOiBsCkZZMf
         nrHeNTBb/DgcBrvSau62QmAMRo4MXAAcpdpl4g9jbjU9/esTdMX0elG2EbR5VLo+teL7
         nPKUXc8WoP1WcX+aoiGiLHJg4c88q/f49EGrLqUim8DlDfBBi6aQ7MmwY6uSsg9583Se
         kEOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771073276; x=1771678076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrY9u9fHg6HZdNm0UxLibzOXJWbdwIZ87YpvvsX2F8Q=;
        b=bOpZWWQR+S/WIakveY+n9b6mNMlGTNZ6ZnezggCfDV7I2wIcFcgB3cjaVXHQ5OR/gw
         /sYkHFtkSIjQK96eVxj9DwDgP2th4kjnhLJ3JC8VCbbIVUPeWEML1h5mUCJ8FBmsfYeu
         j6vJbrvfC1aQ0PV4PooLZtafD/6DLgYAb+pnl08q2nYEsj+QFgSgGL55K+9/XBX4BJ0h
         SJOHwgrNA3wTHC6AZZ3GbO5IZpqfobNXkulLKq8VWYbQvAtKrn3k1m+q1eXagHOg3eDt
         jtauMDD8NVOqSXB5G2KZwphRQXgmAWVsjkK8/4mzLnK0qlZ14Rpfezocl4nBt+pjJ4MK
         cwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771073276; x=1771678076;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrY9u9fHg6HZdNm0UxLibzOXJWbdwIZ87YpvvsX2F8Q=;
        b=SdC6qAhLJl1lGdDwNZwRwD0+erQbSVsBOCKZOMELbqnbZgUSzT8ISMBddk1bCKOAKS
         7n0Cj+Cd5TFnLby9gWYO27JM6EUNe3eWo31wgDz6H1SEEKCcjtaKxVbb2lwTVgbO50PK
         swmdDVKSoVdRypas1NXFeiB5wiEuoahwGeaeRmlLp94mT0O2QxIukaVnJmY29OMDlC7Q
         0YFQBIZ5RDyanK1a39b+bqMC2u9oiI4qnmwn2evirkkEWzJM4W9VtwTsIya/ME+2GC5h
         DGS6jyJwuJ0njl5d/Flod9Mp46bjSaUN0u97XfTApSH4tWy+CHpV0y6tYW3k/91Dcv0v
         gaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbRKODeP+QwWujCYPpFfJFbF3AuIjktDY8xvzbdXTUkKI4Kl5wZnfrEnfEly/cPRdMcxgfukl3Xxfa82xA@vger.kernel.org
X-Gm-Message-State: AOJu0YzFSCdKT5l80NOShK4eEYbtxoMXnrboAY8cKEaePqJLIZZJ4AS2
	OfuDB/d1QodYTn/ZdVp1FuCI8gY7RzsVcglobB78rplcVbhUORyvLRm23athyj5yzeRZTb7pchC
	jN7xG6a1rVsNpInZMCnMsH63BisHzoLM=
X-Gm-Gg: AZuq6aKZQlPNwhdBWqQEMK3wZoUDu9ruvQYJaTII9ygu1Oz1VfSX9Jq37p8mFmU5Yge
	jJmPlHDcMsNOngucRJmbLA/Kr1Fi4aNuxVMEq4v4KOjgl7FHvPMiONkjwgBqy/Af6XypTdafoeF
	dhT3W6yrlJzKqFwDlcjJ9bq8aI3a+8h+BhTSpWRBa9Y+CJHKEGrZnn39DzInqaAwKDUVGuDmUDn
	CbDwPUGjYKqd8OzBvJAmiKH2TLZEeumBBU9mRvboJcXtaPRZzRMZTrFC1YDwqu605RJCeoGwXXb
	tkV4lEITXoWCBWUQ8xG7/ElXZq+EWq/Kj++8u4ledx8=
X-Received: by 2002:a9d:7e93:0:b0:7d4:be1d:e9a9 with SMTP id
 46e09a7af769-7d4cde2b347mr1229197a34.6.1771073275796; Sat, 14 Feb 2026
 04:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wojciech <wojciech.develop@gmail.com>
Date: Sat, 14 Feb 2026 13:47:44 +0100
X-Gm-Features: AaiRm529026jPT8v5SF6BWusT8mhr0kNglXaIzJpexvGkMJH2yPT3ATpaspfXB0
Message-ID: <CALGt97-amOrBjW0LStyJSoT=n0TsR8nbEuE8rk7ME4joq51+5w@mail.gmail.com>
Subject: [PATCH v2] docs: proc: fix double whitespace
To: corbet@lwn.net, adobriyan@gmail.com
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lwn.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77209-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wojciechdevelop@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92A5F13BF54
X-Rspamd-Action: no action

From 67259d718da986c176cb45f861a43eb04dfc481b Mon Sep 17 00:00:00 2001
From: "Wojciech S." <wojciech.develop@gmail.com>
Date: Sat, 14 Feb 2026 09:51:35 +0100
Subject: [PATCH] docs: proc: fix double whitespace

v2: Corrected Signed-off-by email address.
Remove an unintended double whitespace in proc.rst.

Signed-off-by: Wojciech S. <wojciech.develop@gmail.com>
---
 Documentation/filesystems/proc.rst | 268 ++++++++++++++---------------
 1 file changed, 134 insertions(+), 134 deletions(-)

diff --git a/Documentation/filesystems/proc.rst
b/Documentation/filesystems/proc.rst
index 8256e857e..b82d94205 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -61,21 +61,21 @@ Preface
 0.1 Introduction/Credits
 ------------------------

-We'd like  to  thank Alan Cox, Rik van Riel, and Alexey Kuznetsov and a lot of
+We'd like to thank Alan Cox, Rik van Riel, and Alexey Kuznetsov and a lot of
 other people for help compiling this documentation. We'd also like to extend a
-special thank  you to Andi Kleen for documentation, which we relied on heavily
-to create  this  document,  as well as the additional information he provided.
-Thanks to  everybody  else  who contributed source or docs to the Linux kernel
+special thank you to Andi Kleen for documentation, which we relied on heavily
+to create this document, as well as the additional information he provided.
+Thanks to everybody else who contributed source or docs to the Linux kernel
 and helped create a great piece of software... :)

-The   latest   version    of   this   document   is    available   online   at
+The latest version of this document is available online at
 https://www.kernel.org/doc/html/latest/filesystems/proc.html

 0.2 Legal Stuff
 ---------------

-We don't  guarantee  the  correctness  of this document, and if you come to us
-complaining about  how  you  screwed  up  your  system  because  of  incorrect
+We don't guarantee the correctness of this document, and if you come to us
+complaining about how you screwed up your system because of incorrect
 documentation, we won't feel responsible...

 Chapter 1: Collecting System Information
@@ -83,28 +83,28 @@ Chapter 1: Collecting System Information

 In This Chapter
 ---------------
-* Investigating  the  properties  of  the  pseudo  file  system  /proc and its
+* Investigating the properties of the pseudo file system /proc and its
   ability to provide information on the running Linux system
 * Examining /proc's structure
-* Uncovering  various  information  about the kernel and the processes running
+* Uncovering various information about the kernel and the processes running
   on the system

 ------------------------------------------------------------------------------

-The proc  file  system acts as an interface to internal data structures in the
-kernel. It  can  be  used to obtain information about the system and to change
+The proc file system acts as an interface to internal data structures in the
+kernel. It can be used to obtain information about the system and to change
 certain kernel parameters at runtime (sysctl).

-First, we'll  take  a  look  at the read-only parts of /proc. In Chapter 2, we
+First, we'll take a look at the read-only parts of /proc. In Chapter 2, we
 show you how you can use /proc/sys to change settings.

 1.1 Process-Specific Subdirectories
 -----------------------------------

-The directory  /proc  contains  (among other things) one subdirectory for each
+The directory /proc contains (among other things) one subdirectory for each
 process running on the system, which is named after the process ID (PID).

-The link  'self'  points to  the process reading the file system. Each process
+The link 'self' points to the process reading the file system. Each process
 subdirectory has the entries listed in Table 1-1.

 A process can read its own information from /proc/PID/* with no extra
@@ -149,7 +149,7 @@ usually fail with ESRCH.
  stack Report full stack trace, enable via CONFIG_STACKTRACE
  smaps An extension based on maps, showing the memory consumption of
  each mapping and flags associated with it
- smaps_rollup Accumulated smaps stats for all mappings of the process.  This
+ smaps_rollup Accumulated smaps stats for all mappings of the process. This
  can be derived from smaps, but is faster and more convenient
  numa_maps An extension based on maps, showing the memory locality and
  binding policy as well as mem usage (in pages) of each mapping.
@@ -207,13 +207,13 @@ read the file /proc/PID/status::
   nonvoluntary_ctxt_switches:     1

 This shows you nearly the same information you would get if you viewed it with
-the ps  command.  In  fact,  ps  uses  the  proc  file  system  to  obtain its
-information.  But you get a more detailed  view of the  process by reading the
+the ps command. In fact, ps uses the proc file system to obtain its
+information. But you get a more detailed view of the process by reading the
 file /proc/PID/status. It fields are described in table 1-2.

-The  statm  file  contains  more  detailed  information about the process
-memory usage. Its seven fields are explained in Table 1-3.  The stat file
-contains detailed information about the process itself.  Its fields are
+The statm file contains more detailed information about the process
+memory usage. Its seven fields are explained in Table 1-3. The stat file
+contains detailed information about the process itself. Its fields are
 explained in Table 1-4.

 (for SMP CONFIG users)
@@ -416,9 +416,9 @@ is a set of permissions::
  p = private (copy on write)

 "offset" is the offset into the mapping, "dev" is the device (major:minor), and
-"inode" is the inode  on that device.  0 indicates that  no inode is associated
+"inode" is the inode on that device. 0 indicates that no inode is associated
 with the memory region, as the case would be with BSS (uninitialized data).
-The "pathname" shows the name associated file for this mapping.  If the mapping
+The "pathname" shows the name associated file for this mapping. If the mapping
 is not associated with a file:

  ===================        ===========================================
@@ -476,7 +476,7 @@ Memory Area, or VMA) there is a series of lines
such as the following::
     VmFlags: rd ex mr mw me dw

 The first of these lines shows the same information as is displayed for
-the mapping in /proc/PID/maps.  Following lines show the size of the
+the mapping in /proc/PID/maps. Following lines show the size of the
 mapping (size); the size of each page allocated when backing a VMA
 (KernelPageSize), which is usually the same as the size in the page table
 entries; the page size used by the MMU when backing a VMA (in most cases,
@@ -488,8 +488,8 @@ mapping.
 The "proportional set size" (PSS) of a process is the count of pages it has
 in memory, where each page is divided by the number of processes sharing it.
 So if a process has 1000 pages all to itself, and 1000 shared with one other
-process, its PSS will be 1500.  "Pss_Dirty" is the portion of PSS which
-consists of dirty pages.  ("Pss_Clean" is not included, but it can be
+process, its PSS will be 1500. "Pss_Dirty" is the portion of PSS which
+consists of dirty pages. ("Pss_Clean" is not included, but it can be
 calculated by subtracting "Pss_Dirty" from "Pss".)

 Traditionally, a page is accounted as "private" if it is mapped exactly once,
@@ -515,7 +515,7 @@ will be imprecise in this case.
 "Referenced" indicates the amount of memory currently marked as referenced or
 accessed.

-"Anonymous" shows the amount of memory that does not belong to any file.  Even
+"Anonymous" shows the amount of memory that does not belong to any file. Even
 a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
 and a page is modified, the file page is replaced by a private anonymous copy.

@@ -607,7 +607,7 @@ Note: reading /proc/PID/maps or /proc/PID/smaps is
inherently racy (consistent
 output can be achieved only in the single read call).

 This typically manifests when doing partial reads of these files while the
-memory map is being modified.  Despite the races, we do provide the following
+memory map is being modified. Despite the races, we do provide the following
 guarantees:

 1) The mapped addresses never go backwards, which implies no two
@@ -617,14 +617,14 @@ guarantees:

 The /proc/PID/smaps_rollup file includes the same fields as /proc/PID/smaps,
 but their values are the sums of the corresponding values for all mappings of
-the process.  Additionally, it contains these fields:
+the process. Additionally, it contains these fields:

 - Pss_Anon
 - Pss_File
 - Pss_Shmem

 They represent the proportional shares of anonymous, file, and shmem pages, as
-described for smaps above.  These fields are omitted in smaps since each
+described for smaps above. These fields are omitted in smaps since each
 mapping identifies the type (anon, file, or shmem) of all pages it contains.
 Thus all information in smaps_rollup can be derived from smaps, but at a
 significantly higher cost.
@@ -703,10 +703,10 @@ per page in such a larger allocation instead.
 1.2 Kernel data
 ---------------

-Similar to  the  process entries, the kernel data files give information about
+Similar to the process entries, the kernel data files give information about
 the running kernel. The files used to obtain this information are contained in
-/proc and  are  listed  in Table 1-5. Not all of these will be present in your
-system. It  depends  on the kernel configuration and the loaded modules, which
+/proc and are listed in Table 1-5. Not all of these will be present in your
+system. It depends on the kernel configuration and the loaded modules, which
 files are there, and which are missing.

 .. table:: Table 1-5: Kernel info in /proc
@@ -775,7 +775,7 @@ files are there, and which are missing.
  vmallocinfo  Show vmalloced areas
  ============ ===============================================================

-You can,  for  example,  check  which interrupts are currently in use and what
+You can, for  example, check which interrupts are currently in use and what
 they are used for by looking in the file /proc/interrupts::

   > cat /proc/interrupts
@@ -826,36 +826,36 @@ connects the CPUs in a SMP system. This means
that an error has been detected,
 the IO-APIC automatically retry the transmission, so it should not be a big
 problem, but you should read the SMP-FAQ.

-In 2.6.2* /proc/interrupts was expanded again.  This time the goal was for
+In 2.6.2* /proc/interrupts was expanded again. This time the goal was for
 /proc/interrupts to display every IRQ vector in use by the system, not
-just those considered 'most important'.  The new vectors are:
+just those considered 'most important'. The new vectors are:

 THR
   interrupt raised when a machine check threshold counter
   (typically counting ECC corrected errors of memory or cache) exceeds
-  a configurable threshold.  Only available on some systems.
+  a configurable threshold. Only available on some systems.

 TRM
   a thermal event interrupt occurs when a temperature threshold
-  has been exceeded for the CPU.  This interrupt may also be generated
+  has been exceeded for the CPU. This interrupt may also be generated
   when the temperature drops back to normal.

 SPU
   a spurious interrupt is some interrupt that was raised then lowered
-  by some IO device before it could be fully processed by the APIC.  Hence
+  by some IO device before it could be fully processed by the APIC. Hence
   the APIC sees the interrupt but does not know what device it came from.
   For this case the APIC will generate the interrupt with a IRQ vector
   of 0xff. This might also be generated by chipset bugs.

 RES, CAL, TLB
   rescheduling, call and TLB flush interrupts are
-  sent from one CPU to another per the needs of the OS.  Typically,
+  sent from one CPU to another per the needs of the OS. Typically,
   their statistics are used by kernel developers and interested users to
   determine the occurrence of interrupts of the given type.

-The above IRQ vectors are displayed only when relevant.  For example,
-the threshold vector does not exist on x86_64 platforms.  Others are
-suppressed when the system is a uniprocessor.  As of this writing, only
+The above IRQ vectors are displayed only when relevant. For example,
+the threshold vector does not exist on x86_64 platforms. Others are
+suppressed when the system is a uniprocessor. As of this writing, only
 i386 and x86_64 platforms support the new IRQ vector displays.

 Of some interest is the introduction of the /proc/irq directory to 2.4.
@@ -905,18 +905,18 @@ profiler. Default value is ffffffff (all CPUs if
there are only 32 of them).
 The way IRQs are routed is handled by the IO-APIC, and it's Round Robin
 between all the CPUs which are allowed to handle it. As usual the kernel has
 more info than you and does a better job than you, so the defaults are the
-best choice for almost everyone.  [Note this applies only to those IO-APIC's
+best choice for almost everyone. [Note this applies only to those IO-APIC's
 that support "Round Robin" interrupt distribution.]

-There are  three  more  important subdirectories in /proc: net, scsi, and sys.
-The general  rule  is  that  the  contents,  or  even  the  existence of these
-directories, depend  on your kernel configuration. If SCSI is not enabled, the
-directory scsi  may  not  exist. The same is true with the net, which is there
+There are three more important subdirectories in /proc: net, scsi, and sys.
+The general rule is that the contents, or even the existence of these
+directories, depend on your kernel configuration. If SCSI is not enabled, the
+directory scsi may not exist. The same is true with the net, which is there
 only when networking support is present in the running kernel.

-The slabinfo  file  gives  information  about  memory usage at the slab level.
-Linux uses  slab  pools for memory management above page level in version 2.2.
-Commonly used  objects  have  their  own  slab  pool (such as network buffers,
+The slabinfo file gives information about memory usage at the slab level.
+Linux uses slab pools for memory management above page level in version 2.2.
+Commonly used objects have their own slab pool (such as network buffers,
 directory cache, and so on).

 ::
@@ -928,12 +928,12 @@ directory cache, and so on).
     Node 0, zone  HighMem      2      0      0      1      1      0 ...

 External fragmentation is a problem under some workloads, and buddyinfo is a
-useful tool for helping diagnose these problems.  Buddyinfo will give you a
+useful tool for helping diagnose these problems. Buddyinfo will give you a
 clue as to how big an area you can safely allocate, or why a previous
 allocation failed.

 Each column represents the number of pages of a certain order which are
-available.  In this case, there are 0 chunks of 2^0*PAGE_SIZE available in
+available. In this case, there are 0 chunks of 2^0*PAGE_SIZE available in
 ZONE_DMA, 4 chunks of 2^1*PAGE_SIZE in ZONE_DMA, 101 chunks of 2^4*PAGE_SIZE
 available in ZONE_NORMAL, etc...

@@ -1025,11 +1025,11 @@ Example output.
 meminfo
 ~~~~~~~

-Provides information about distribution and utilization of memory.  This
-varies by architecture and compile options.  Some of the counters reported
-here overlap.  The memory reported by the non overlapping counters may not
+Provides information about distribution and utilization of memory. This
+varies by architecture and compile options. Some of the counters reported
+here overlap. The memory reported by the non overlapping counters may not
 add up to the overall memory usage and the difference for some workloads
-can be substantial.  In many cases there are other means to find out
+can be substantial. In many cases there are other means to find out
 additional memory using subsystem specific interfaces, for instance
 /proc/net/sockstat for TCP memory allocations.

@@ -1129,7 +1129,7 @@ Active
               Memory that has been used more recently and usually not
               reclaimed unless absolutely necessary.
 Inactive
-              Memory which has been less recently used.  It is more
+              Memory which has been less recently used. It is more
               eligible to be reclaimed for other purposes
 Unevictable
               Memory allocated for userspace which cannot be reclaimed, such
@@ -1144,9 +1144,9 @@ HighTotal, HighFree
 LowTotal, LowFree
               Lowmem is memory which can be used for everything that
               highmem can be used for, but it is also available for the
-              kernel's use for its own data structures.  Among many
+              kernel's use for its own data structures. Among many
               other things, it is where everything from the Slab is
-              allocated.  Bad things happen when you're out of lowmem.
+              allocated. Bad things happen when you're out of lowmem.
 SwapTotal
               total amount of swap space available
 SwapFree
@@ -1345,8 +1345,8 @@ Provides counts of softirq handlers serviced
since boot time, for each CPU.
 1.3 Networking info in /proc/net
 --------------------------------

-The subdirectory  /proc/net  follows  the  usual  pattern. Table 1-8 shows the
-additional values  you  get  for  IP  version 6 if you configure the kernel to
+The subdirectory /proc/net follows the usual pattern. Table 1-8 shows the
+additional values you get for IP version 6 if you configure the kernel to
 support this. Table 1-9 lists the files and their meaning.


@@ -1400,7 +1400,7 @@ support this. Table 1-9 lists the files and their meaning.
  ip_mr_cache   List of multicast routing cache
  ============= ================================================================

-You can  use  this  information  to see which network devices are available in
+You can use this information to see which network devices are available in
 your system and how much traffic was routed over those devices::

   > cat /proc/net/dev
@@ -1416,7 +1416,7 @@ your system and how much traffic was routed over
those devices::
   ...] 1375103    17405    0    0    0     0       0          0
   ...] 1703981     5535    0    0    0     3       0          0

-In addition, each Channel Bond interface has its own directory.  For
+In addition, each Channel Bond interface has its own directory. For
 example, the bond0 device will have a directory called /proc/net/bond0/.
 It will contain information that is specific to that bond, such as the
 current slaves of the bond, the link status of the slaves, and how
@@ -1439,9 +1439,9 @@ You'll also see a list of all recognized SCSI
devices in /proc/scsi::
     Type:   CD-ROM                           ANSI SCSI revision: 02


-The directory  named  after  the driver has one file for each adapter found in
-the system.  These  files  contain information about the controller, including
-the used  IRQ  and  the  IO  address range. The amount of information shown is
+The directory named after the driver has one file for each adapter found in
+the system. These files contain information about the controller, including
+the used IRQ and the IO address range. The amount of information shown is
 dependent on  the adapter you use. The example shows the output for an Adaptec
 AHA-2940 SCSI adapter::

@@ -1488,8 +1488,8 @@ AHA-2940 SCSI adapter::
 1.5 Parallel port info in /proc/parport
 ---------------------------------------

-The directory  /proc/parport  contains information about the parallel ports of
-your system.  It  has  one  subdirectory  for  each port, named after the port
+The directory /proc/parport contains information about the parallel ports of
+your system. It has one subdirectory for each port, named after the port
 number (0,1,2,...).

 These directories contain the four files shown in Table 1-10.
@@ -1513,8 +1513,8 @@ These directories contain the four files shown
in Table 1-10.
 1.6 TTY info in /proc/tty
 -------------------------

-Information about  the  available  and actually used tty's can be found in the
-directory /proc/tty. You'll find  entries  for drivers and line disciplines in
+Information about the available and actually used tty's can be found in the
+directory /proc/tty. You'll find entries for drivers and line disciplines in
 this directory, as shown in Table 1-11.


@@ -1528,7 +1528,7 @@ this directory, as shown in Table 1-11.
  driver/serial usage statistic and status of single tty lines
  ============= ==============================================

-To see  which  tty's  are  currently in use, you can simply look into the file
+To see which tty's are currently in use, you can simply look into the file
 /proc/tty/drivers::

   > cat /proc/tty/drivers
@@ -1548,9 +1548,9 @@ To see  which  tty's  are  currently in use, you
can simply look into the file
 1.7 Miscellaneous kernel statistics in /proc/stat
 -------------------------------------------------

-Various pieces   of  information about  kernel activity  are  available in the
-/proc/stat file.  All  of  the numbers reported  in  this file are  aggregates
-since the system first booted.  For a quick look, simply cat the file::
+Various pieces of information about kernel activity are available in the
+/proc/stat file. All of the numbers reported in this file are aggregates
+since the system first booted. For a quick look, simply cat the file::

   > cat /proc/stat
   cpu  237902850 368826709 106375398 1873517540 1135548 0 14507935 0 0 0
@@ -1566,10 +1566,10 @@ since the system first booted.  For a quick
look, simply cat the file::
   procs_blocked 0
   softirq 12121874454 100099120 3938138295 127375644 2795979
187870761 0 173808342 3072582055 52608 224184354

-The very first  "cpu" line aggregates the  numbers in all  of the other "cpuN"
-lines.  These numbers identify the amount of time the CPU has spent performing
-different kinds of work.  Time units are in USER_HZ (typically hundredths of a
-second).  The meanings of the columns are as follows, from left to right:
+The very first "cpu" line aggregates the numbers in all of the other "cpuN"
+lines. These numbers identify the amount of time the CPU has spent performing
+different kinds of work. Time units are in USER_HZ (typically hundredths of a
+second). The meanings of the columns are as follows, from left to right:

 - user: normal processes executing in user mode
 - nice: niced processes executing in user mode
@@ -1593,25 +1593,25 @@ second).  The meanings of the columns are as
follows, from left to right:
 - guest: running a normal guest
 - guest_nice: running a niced guest

-The "intr" line gives counts of interrupts  serviced since boot time, for each
-of the  possible system interrupts.   The first  column  is the  total of  all
-interrupts serviced  including  unnumbered  architecture specific  interrupts;
-each  subsequent column is the  total for that particular numbered interrupt.
+The "intr" line gives counts of interrupts serviced since boot time, for each
+of the possible system interrupts. The first column is the total of all
+interrupts serviced including unnumbered architecture specific interrupts;
+each subsequent column is the total for that particular numbered interrupt.
 Unnumbered interrupts are not shown, only summed into the total.

 The "ctxt" line gives the total number of context switches across all CPUs.

-The "btime" line gives  the time at which the  system booted, in seconds since
+The "btime" line gives the time at which the system booted, in seconds since
 the Unix epoch.

-The "processes" line gives the number  of processes and threads created, which
-includes (but  is not limited  to) those  created by  calls to the  fork() and
+The "processes" line gives the number of processes and threads created, which
+includes (but is not limited to) those created by calls to the fork() and
 clone() system calls.

 The "procs_running" line gives the total number of threads that are
 running or ready to run (i.e., the total number of runnable threads).

-The   "procs_blocked" line gives  the  number of  processes currently blocked,
+The "procs_blocked" line gives the number of processes currently blocked,
 waiting for I/O to complete.

 The "softirq" line gives counts of softirqs serviced since boot time, for each
@@ -1624,9 +1624,9 @@ softirq.
 -------------------------------

 Information about mounted ext4 file systems can be found in
-/proc/fs/ext4.  Each mounted filesystem will have a directory in
+/proc/fs/ext4. Each mounted filesystem will have a directory in
 /proc/fs/ext4 based on its device name (i.e., /proc/fs/ext4/hdc or
-/proc/fs/ext4/sda9 or /proc/fs/ext4/dm-0).   The files in each per-device
+/proc/fs/ext4/sda9 or /proc/fs/ext4/dm-0). The files in each per-device
 directory are shown in Table 1-12, below.

 .. table:: Table 1-12: Files in /proc/fs/ext4/<devname>
@@ -1674,7 +1674,7 @@ The /proc file system serves information about
the running system. It not only
 allows access to process data but also allows you to request the kernel status
 by reading files in the hierarchy.

-The directory  structure  of /proc reflects the types of information and makes
+The directory structure of /proc reflects the types of information and makes
 it easy, if not obvious, where to look for specific data.

 Chapter 2: Modifying System Parameters
@@ -1689,26 +1689,26 @@ In This Chapter

 ------------------------------------------------------------------------------

-A very  interesting part of /proc is the directory /proc/sys. This is not only
-a source  of  information,  it also allows you to change parameters within the
-kernel. Be  very  careful  when attempting this. You can optimize your system,
-but you  can  also  cause  it  to  crash.  Never  alter kernel parameters on a
-production system.  Set  up  a  development machine and test to make sure that
-everything works  the  way  you want it to. You may have no alternative but to
+A very interesting part of /proc is the directory /proc/sys. This is not only
+a source of information, it also allows you to change parameters within the
+kernel. Be very careful when attempting this. You can optimize your system,
+but you can also cause it to crash. Never alter kernel parameters on a
+production system. Set up a development machine and test to make sure that
+everything works the way you want it to. You may have no alternative but to
 reboot the machine once an error has been made.

-To change  a  value,  simply  echo  the new value into the file.
-You need to be root to do this. You  can  create  your  own  boot script
+To change a value, simply echo the new value into the file.
+You need to be root to do this. You can create your own boot script
 to perform this every time your system boots.

-The files  in /proc/sys can be used to fine tune and monitor miscellaneous and
-general things  in  the operation of the Linux kernel. Since some of the files
-can inadvertently  disrupt  your  system,  it  is  advisable  to  read  both
-documentation and  source  before actually making adjustments. In any case, be
-very careful  when  writing  to  any  of these files. The entries in /proc may
+The files in /proc/sys can be used to fine tune and monitor miscellaneous and
+general things in the operation of the Linux kernel. Since some of the files
+can inadvertently disrupt your system, it is advisable to read both
+documentation and source before actually making adjustments. In any case, be
+very careful when writing to any of these files. The entries in /proc may
 change slightly between the 2.1.* and the 2.2 kernel, so if there is any doubt
 review the kernel documentation in the directory linux/Documentation.
-This chapter  is  heavily  based  on the documentation included in the pre 2.2
+This chapter is heavily based on the documentation included in the pre 2.2
 kernels, and became part of it in version 2.2.1 of the Linux kernel.

 Please see: Documentation/admin-guide/sysctl/ directory for descriptions of
@@ -1717,9 +1717,9 @@ these entries.
 Summary
 -------

-Certain aspects  of  kernel  behavior  can be modified at runtime, without the
-need to  recompile  the kernel, or even to reboot the system. The files in the
-/proc/sys tree  can  not only be read, but also modified. You can use the echo
+Certain aspects of kernel behavior can be modified at runtime, without the
+need to recompile the kernel, or even to reboot the system. The files in the
+/proc/sys tree can not only be read, but also modified. You can use the echo
 command to write value into these files, thereby changing the default settings
 of the kernel.

@@ -1734,41 +1734,41 @@ These files can be used to adjust the badness
heuristic used to select which
 process gets killed in out of memory (oom) conditions.

 The badness heuristic assigns a value to each candidate task ranging from 0
-(never kill) to 1000 (always kill) to determine which process is targeted.  The
+(never kill) to 1000 (always kill) to determine which process is targeted. The
 units are roughly a proportion along that range of allowed memory the process
 may allocate from based on an estimation of its current memory and swap use.
 For example, if a task is using all allowed memory, its badness score will be
-1000.  If it is using half of its allowed memory, its score will be 500.
+1000. If it is using half of its allowed memory, its score will be 500.

 The amount of "allowed" memory depends on the context in which the oom killer
-was called.  If it is due to the memory assigned to the allocating
task's cpuset
+was called. If it is due to the memory assigned to the allocating task's cpuset
 being exhausted, the allowed memory represents the set of mems assigned to that
-cpuset.  If it is due to a mempolicy's node(s) being exhausted, the allowed
-memory represents the set of mempolicy nodes.  If it is due to a memory
+cpuset. If it is due to a mempolicy's node(s) being exhausted, the allowed
+memory represents the set of mempolicy nodes. If it is due to a memory
 limit (or swap limit) being reached, the allowed memory is that configured
-limit.  Finally, if it is due to the entire system being out of memory, the
+limit. Finally, if it is due to the entire system being out of memory, the
 allowed memory represents all allocatable resources.

 The value of /proc/<pid>/oom_score_adj is added to the badness score before it
-is used to determine which task to kill.  Acceptable values range from -1000
-(OOM_SCORE_ADJ_MIN) to +1000 (OOM_SCORE_ADJ_MAX).  This allows userspace to
+is used to determine which task to kill. Acceptable values range from -1000
+(OOM_SCORE_ADJ_MIN) to +1000 (OOM_SCORE_ADJ_MAX). This allows userspace to
 polarize the preference for oom killing either by always preferring a certain
-task or completely disabling it.  The lowest possible value, -1000, is
+task or completely disabling it. The lowest possible value, -1000, is
 equivalent to disabling oom killing entirely for that task since it will always
 report a badness score of 0.

 Consequently, it is very simple for userspace to define the amount of memory to
-consider for each task.  Setting a /proc/<pid>/oom_score_adj value of +500, for
+consider for each task. Setting a /proc/<pid>/oom_score_adj value of +500, for
 example, is roughly equivalent to allowing the remainder of tasks sharing the
 same system, cpuset, mempolicy, or memory controller resources to use at least
-50% more memory.  A value of -500, on the other hand, would be roughly
+50% more memory. A value of -500, on the other hand, would be roughly
 equivalent to discounting 50% of the task's allowed memory from being
considered
 as scoring against the task.

 For backwards compatibility with previous kernels, /proc/<pid>/oom_adj may also
-be used to tune the badness score.  Its acceptable values range from -16
+be used to tune the badness score. Its acceptable values range from -16
 (OOM_ADJUST_MIN) to +15 (OOM_ADJUST_MAX) and a special value of -17
-(OOM_DISABLE) to disable oom killing entirely for that task.  Its value is
+(OOM_DISABLE) to disable oom killing entirely for that task. Its value is
 scaled linearly with /proc/<pid>/oom_score_adj.

 The value of /proc/<pid>/oom_score_adj may be reduced no lower than the last
@@ -1787,7 +1787,7 @@ Please note that the exported value includes
oom_score_adj so it is
 effectively in range [0,2000].


-3.3  /proc/<pid>/io - Display the IO accounting fields
+3.3 /proc/<pid>/io - Display the IO accounting fields
 -------------------------------------------------------

 This file contains IO statistics for each running process.
@@ -2090,7 +2090,7 @@ target file resides and the 'mask' is the mask
of events, all in hex
 form [see inotify(7) for more details].

 If the kernel was built with exportfs support, the path to the target
-file is encoded as a file handle.  The file handle is provided by three
+file is encoded as a file handle. The file handle is provided by three
 fields 'fhandle-bytes', 'fhandle-type' and 'f_handle', all in hex
 format.

@@ -2191,7 +2191,7 @@ vm_area_struct::vm_start-vm_area_struct::vm_end.

 The main purpose of the map_files is to retrieve a set of memory mapped
 files in a fast way instead of parsing /proc/<pid>/maps or
-/proc/<pid>/smaps, both of which contain many more records.  At the same
+/proc/<pid>/smaps, both of which contain many more records. At the same
 time one can open(2) mappings from the listings of two processes and
 comparing their inode numbers to figure out which anonymous memory areas
 are actually shared.
@@ -2220,13 +2220,13 @@ patch state for the task.
 A value of '-1' indicates that no patch is in transition.

 A value of '0' indicates that a patch is in transition and the task is
-unpatched.  If the patch is being enabled, then the task hasn't been
-patched yet.  If the patch is being disabled, then the task has already
+unpatched. If the patch is being enabled, then the task hasn't been
+patched yet. If the patch is being disabled, then the task has already
 been unpatched.

 A value of '1' indicates that a patch is in transition and the task is
-patched.  If the patch is being enabled, then the task has already been
-patched.  If the patch is being disabled, then the task hasn't been
+patched. If the patch is being enabled, then the task has already been
+patched. If the patch is being disabled, then the task hasn't been
 unpatched yet.

 3.12 /proc/<pid>/arch_status - task architecture specific status
@@ -2313,9 +2313,9 @@ Description
 ksm_rmap_items
 ^^^^^^^^^^^^^^

-The number of ksm_rmap_item structures in use.  The structure
+The number of ksm_rmap_item structures in use. The structure
 ksm_rmap_item stores the reverse mapping information for virtual
-addresses.  KSM will generate a ksm_rmap_item for each ksm-scanned page of
+addresses. KSM will generate a ksm_rmap_item for each ksm-scanned page of
 the process.

 ksm_zero_pages
@@ -2377,18 +2377,18 @@ hidepid=off or hidepid=0 means classic mode -
everybody may access all
 /proc/<pid>/ directories (default).

 hidepid=noaccess or hidepid=1 means users may not access any /proc/<pid>/
-directories but their own.  Sensitive files like cmdline, sched*,
status are now
-protected against other users.  This makes it impossible to learn whether any
+directories but their own. Sensitive files like cmdline, sched*, status are now
+protected against other users. This makes it impossible to learn whether any
 user runs specific program (given the program doesn't reveal itself by its
-behaviour).  As an additional bonus, as /proc/<pid>/cmdline is unaccessible for
+behaviour). As an additional bonus, as /proc/<pid>/cmdline is unaccessible for
 other users, poorly written programs passing sensitive information via program
 arguments are now protected against local eavesdroppers.

 hidepid=invisible or hidepid=2 means hidepid=1 plus all /proc/<pid>/ will be
-fully invisible to other users.  It doesn't mean that it hides a fact whether a
+fully invisible to other users. It doesn't mean that it hides a fact whether a
 process with a specific pid value exists (it can be learned by other
means, e.g.
 by "kill -0 $PID"), but it hides process's uid and gid, which may be learned by
-stat()'ing /proc/<pid>/ otherwise.  It greatly complicates an
intruder's task of
+stat()'ing /proc/<pid>/ otherwise. It greatly complicates an intruder's task of
 gathering information about running processes, whether some daemon runs with
 elevated privileges, whether other user runs some sensitive program, whether
 other users run any parogram at all, etc.
@@ -2397,7 +2397,7 @@ hidepid=ptraceable or hidepid=4 means that
procfs should only contain
 /proc/<pid>/ directories that the caller can ptrace.

 gid= defines a group authorized to learn processes information otherwise
-prohibited by hidepid=.  If you use some daemon like identd which
needs to learn
+prohibited by hidepid=. If you use some daemon like identd which needs to learn
 information about processes information, just add identd to this group.

 subset=pid hides all top level files and directories in the procfs that
--
2.47.3

