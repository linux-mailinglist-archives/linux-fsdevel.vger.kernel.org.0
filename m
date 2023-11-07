Return-Path: <linux-fsdevel+bounces-2206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B347E3474
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 05:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7731D1C20A20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7B8F74;
	Tue,  7 Nov 2023 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghefhjEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1BA79F2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 04:17:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F0FD
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 20:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699330651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OEClqip8Hd/4yw5LjGu4+pn6BbKEnTze4Tcl/EjSE1A=;
	b=ghefhjECicNOHDe6F2R7btmcAx3IEyvUmJ5FBEu4nonJzvZ52lv94RAWnozoxV+zJQySl/
	UADRqh+PMbiTaJOy3PRaxOLQPwW5EBnSeflGgTnKJwSaXXCLoUGNt3nDIkDfgoauFgaRfc
	HEbBU4h0tuBOPVjoOnJC3vhV+la1UQw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ZCu2GYxTNuOI66Owdu5__A-1; Mon, 06 Nov 2023 23:17:29 -0500
X-MC-Unique: ZCu2GYxTNuOI66Owdu5__A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28011e1cdcbso4515376a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 20:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699330648; x=1699935448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEClqip8Hd/4yw5LjGu4+pn6BbKEnTze4Tcl/EjSE1A=;
        b=Br2B8R+EielniMgx7tjy4SvSnRq0S3Pl3E9VkgCMZUF5PG1u732blrpXf1Ss+D2Z2Y
         cNZsbc7HE9Kjp62WFjJJm5uhgI6yR4gKR2IZaqdDf87l7Ddkd54tIamras/B0WFft5bE
         w9UGIwiTHG2I57k5t8hjbEBNs3th/iHmGwHYPW6keA007U42FJoPr8XE2ZYuB3Eg7nAu
         kkLoYhZvo1ZBa2r132is7Zt+Xgp+U5GznHHPv2tUw0hq8qFSwpfo7660dXaE3Exmmi+1
         xpjS177qP67ZAjTiAhUBUfbd0TGU6l3rzPlFEA+0T62+znbi10Ghx+ejd4T1tez5VuYU
         7/Zw==
X-Gm-Message-State: AOJu0YzmCWd132AjrDHlR68GNFYX8TVoWfjRg9cfUNc6QfLCetcjqoYI
	uBEV1GxEuVsvdYdd2bVGwtTUH1DCnaU26Bi88wLuA67AJvBTYPRoCiJeMLQSWlA4uf94A4elOO7
	K2lLyNTvRxPxkLpMebPNM6pstSw==
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr27501632plx.57.1699330647981;
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/bDSpYLFMGA8/IP0/ZDBgoerLMJpNRCRJpSAHrDXrDr7fFUbf3eUOwgyPRyBg+Ru2wXoVVg==
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr27501620plx.57.1699330647618;
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
Received: from [192.168.68.219] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001c898328289sm6636558plf.158.2023.11.06.20.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
Message-ID: <26101f57-e5b3-e07b-c67f-259ab820cb0d@redhat.com>
Date: Tue, 7 Nov 2023 12:17:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: autofs mailing list <autofs@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Ian Kent <ikent@redhat.com>
Subject: [ANNOUNCE] autofs 5.1.9 release
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

A release is long overdue so here it is, autofs-5.1.9.

There are quite a lot of changes in the release but they are mostly
bug fixes arising from a number significant improvements done over
the last several releases.

Some general performance overheads have crept in over quite a while
and work has been done to improve on it but once the obvious is done
it gets much harder to improve, so that's ongoing as time permits.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.9.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.9.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.9.tar.gz

Here are the entries from the CHANGELOG which outline the updates:

- fix kernel mount status notification.
- fix fedfs build flags.
- fix set open file limit.
- improve descriptor open error reporting.
- fix root offset error handling.
- fix fix root offset error handling.
- fix nonstrict fail handling of last offset mount.
- dont fail on duplicate offset entry tree add.
- fix loop under run in cache_get_offset_parent().
- bailout on rpc systemerror.
- fix nfsv4 only mounts should not use rpcbind.
- simplify cache_add() a little.
- fix use after free in tree_mapent_delete_offset_tree().
- fix memory leak in xdr_exports().
- avoid calling pthread_getspecific() with NULL key_thread_attempt_id.
- fix sysconf(3) return handling.
- remove nonstrict parameter from tree_mapent_umount_offsets().
- fix handling of incorrect return from umount_ent().
- dont use initgroups() at spawn.
- fix bashism in configure.
- musl: fix missing include in hash.h.
- musl: define fallback dummy NSS config path
- musl: avoid internal stat.h definitions.
- musl: add missing include to hash.h for _WORDSIZE.
- musl: add missing include to log.h for pid_t.
- musl: define _SWORD_TYPE.
- add autofs_strerror_r() helper for musl.
- update configure.
- handle innetgr() not present in musl.
- fix missing unlock in sasl_do_kinit_ext_cc().
- fix a couple of null cache locking problems.
- restore gcc flags after autoconf Kerberos 5 check.
- prepare for OpenLDAP SASL binding.
- let OpenLDAP handle SASL binding.
- configure: LDAP function checks ignore implicit declarations.
- improve debug logging of LDAP binds.
- improve debug logging of SASL binds.
- internal SASL logging only in debug log mode.
- more comprehensive verbose logging for LDAP maps.
- fix invalid tsv access.
- support SCRAM for SASL binding.
- ldap_sasl_interactive_bind() needs credentials for auto-detection.
- fix autofs regression due to positive_timeout.
- fix parse module instance mutex naming.
- serialise lookup module open and reinit.
- coverity fix for invalid access.
- fix hosts map deadlock on restart.
- fix deadlock with hosts map reload.
- fix memory leak in update_hosts_mounts().
- fix minus only option handling in concat_options().
- fix incorrect path for is_mounted() in try_remount().
- fix additional tsv invalid access.
- fix use_ignore_mount_option description.
- include addtional log info for mounts.
- fail on empty replicated host name.
- improve handling of ENOENT in sss setautomntent().
- don't immediately call function when waiting.
- define LDAP_DEPRECATED during LDAP configure check.
- fix return status of mount_autofs().
- don't close lookup at umount.
- fix deadlock in lookups.
- dont delay expire.
- make amd mapent search function name clear.
- rename statemachine() to signal_handler().
- make signal handling consistent.
- eliminate last remaining state_pipe usage.
- add function master_find_mapent_by_devid().
- use device id to locate autofs_point when setting log priotity.
- add command pipe handling functions.
- switch to application wide command pipe.
- get rid of unused field submnt_count.
- fix mount tree startup reconnect.
- fix unterminated read in handle_cmd_pipe_fifo_message().
- fix memory leak in sasl_do_kinit()
- fix fix mount tree startup reconnect.
- fix amd selector function matching.
- get rid entry thid field.
- continue expire immediately after submount check.
- eliminate realpath from mount of submount.
- eliminate root param from autofs mount and umount.
- remove redundant fstat from do_mount_direct().
- get rid of strlen call in handle_packet_missing_direct().
- remove redundant stat call in lookup_ghost().
- set mapent dev and ino before adding to index.
- change to use printf functions in amd parser.
- dont call umount_subtree_mounts() on parent at umount.
- dont take parent source lock at mount shutdown.
- fix possible use after free in handle_mounts_exit().
- make submount cleanup the same as top level mounts.
- add soucre parameter to module functions.
- add ioctlfd open helper.
- make open files limit configurable.
- use correct reference for IN6 macro call.
- dont probe interface that cant send packet.
- fix some sss error return cases.
- fix incorrect matching of cached wildcard key.
- fix expire retry looping.
- allow -null map in indirect maps.
- fix multi-mount check.
- fix let OpenLDAP handle SASL binding.
- always recreate credential cache.
- fix ldap_parse_page_control() check.
- fix typo in create_cmd_pipe_fifo().
- add null check in master_kill().
- be more careful with cmd pipe at exit.
- rename configure.in to configure.ac.
- update autoconf macros.
- update autoconf release.
- update autofs release.

Ian


