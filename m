Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B711458712F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiHATNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiHATMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:12:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE361130;
        Mon,  1 Aug 2022 12:09:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1599D3816B;
        Mon,  1 Aug 2022 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659380989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgeaBfl3YcAl1Jwyt1LREymUfqVKBcMA35+BICkZKIg=;
        b=JvI8ac+bNT/+YIx8SrIv/RnSc6oqWU5baFSuVQFm02vxZfnaiO4hOQqc032TIuSzcp7sEM
        SXHDUh8bff6dI/IC2Vp1OVrh86P0+ETSzWcMm3XQAnI19Mp007pz/6jHdgCi+4gsE83lCi
        cpYFk/9FE/WZ3VWPUfxRBx+rP5KZw7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659380989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgeaBfl3YcAl1Jwyt1LREymUfqVKBcMA35+BICkZKIg=;
        b=kjMrnqNuPu67396zi84jDQSLniSTRNRjWNDS6jH1ato6iEhzR9yffrsBTlqBOdeVGTzzLy
        WEhacKmy/2fziUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83D0113AAE;
        Mon,  1 Aug 2022 19:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SX05Efwk6GKJSgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 01 Aug 2022 19:09:48 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Subject: [RFC PATCH 2/3] smbfs: rename directory "fs/cifs" -> "fs/smbfs"
Date:   Mon,  1 Aug 2022 16:09:32 -0300
Message-Id: <20220801190933.27197-3-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801190933.27197-1-ematsumiya@suse.de>
References: <20220801190933.27197-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update fs/Kconfig and fs/Makefile to reflect the change.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/Kconfig                                       | 2 +-
 fs/Makefile                                      | 2 +-
 fs/{cifs => smbfs}/Kconfig                       | 0
 fs/{cifs => smbfs}/Makefile                      | 0
 fs/{cifs => smbfs}/asn1.c                        | 0
 fs/{cifs => smbfs}/cifs_debug.c                  | 0
 fs/{cifs => smbfs}/cifs_debug.h                  | 0
 fs/{cifs => smbfs}/cifs_dfs_ref.c                | 0
 fs/{cifs => smbfs}/cifs_fs_sb.h                  | 0
 fs/{cifs => smbfs}/cifs_ioctl.h                  | 0
 fs/{cifs => smbfs}/cifs_spnego.c                 | 0
 fs/{cifs => smbfs}/cifs_spnego.h                 | 0
 fs/{cifs => smbfs}/cifs_spnego_negtokeninit.asn1 | 0
 fs/{cifs => smbfs}/cifs_swn.c                    | 0
 fs/{cifs => smbfs}/cifs_swn.h                    | 0
 fs/{cifs => smbfs}/cifs_unicode.c                | 0
 fs/{cifs => smbfs}/cifs_unicode.h                | 0
 fs/{cifs => smbfs}/cifs_uniupr.h                 | 0
 fs/{cifs => smbfs}/cifsacl.c                     | 0
 fs/{cifs => smbfs}/cifsacl.h                     | 0
 fs/{cifs => smbfs}/cifsencrypt.c                 | 0
 fs/{cifs => smbfs}/cifsglob.h                    | 0
 fs/{cifs => smbfs}/cifspdu.h                     | 0
 fs/{cifs => smbfs}/cifsproto.h                   | 0
 fs/{cifs => smbfs}/cifsroot.c                    | 0
 fs/{cifs => smbfs}/cifssmb.c                     | 0
 fs/{cifs => smbfs}/connect.c                     | 0
 fs/{cifs => smbfs}/core.c                        | 0
 fs/{cifs => smbfs}/dfs_cache.c                   | 0
 fs/{cifs => smbfs}/dfs_cache.h                   | 0
 fs/{cifs => smbfs}/dir.c                         | 0
 fs/{cifs => smbfs}/dns_resolve.c                 | 0
 fs/{cifs => smbfs}/dns_resolve.h                 | 0
 fs/{cifs => smbfs}/export.c                      | 0
 fs/{cifs => smbfs}/file.c                        | 0
 fs/{cifs => smbfs}/fs_context.c                  | 0
 fs/{cifs => smbfs}/fs_context.h                  | 0
 fs/{cifs => smbfs}/fscache.c                     | 0
 fs/{cifs => smbfs}/fscache.h                     | 0
 fs/{cifs => smbfs}/inode.c                       | 0
 fs/{cifs => smbfs}/ioctl.c                       | 0
 fs/{cifs => smbfs}/link.c                        | 0
 fs/{cifs => smbfs}/misc.c                        | 0
 fs/{cifs => smbfs}/netlink.c                     | 0
 fs/{cifs => smbfs}/netlink.h                     | 0
 fs/{cifs => smbfs}/netmisc.c                     | 0
 fs/{cifs => smbfs}/nterr.c                       | 0
 fs/{cifs => smbfs}/nterr.h                       | 0
 fs/{cifs => smbfs}/ntlmssp.h                     | 0
 fs/{cifs => smbfs}/readdir.c                     | 0
 fs/{cifs => smbfs}/rfc1002pdu.h                  | 0
 fs/{cifs => smbfs}/sess.c                        | 0
 fs/{cifs => smbfs}/smb1ops.c                     | 0
 fs/{cifs => smbfs}/smb2file.c                    | 0
 fs/{cifs => smbfs}/smb2glob.h                    | 0
 fs/{cifs => smbfs}/smb2inode.c                   | 0
 fs/{cifs => smbfs}/smb2maperror.c                | 0
 fs/{cifs => smbfs}/smb2misc.c                    | 0
 fs/{cifs => smbfs}/smb2ops.c                     | 0
 fs/{cifs => smbfs}/smb2pdu.c                     | 0
 fs/{cifs => smbfs}/smb2pdu.h                     | 0
 fs/{cifs => smbfs}/smb2proto.h                   | 0
 fs/{cifs => smbfs}/smb2status.h                  | 0
 fs/{cifs => smbfs}/smb2transport.c               | 0
 fs/{cifs => smbfs}/smbdirect.c                   | 0
 fs/{cifs => smbfs}/smbdirect.h                   | 0
 fs/{cifs => smbfs}/smbencrypt.c                  | 0
 fs/{cifs => smbfs}/smberr.h                      | 0
 fs/{cifs => smbfs}/smbfs.h                       | 0
 fs/{cifs => smbfs}/trace.c                       | 0
 fs/{cifs => smbfs}/trace.h                       | 0
 fs/{cifs => smbfs}/transport.c                   | 0
 fs/{cifs => smbfs}/unc.c                         | 0
 fs/{cifs => smbfs}/winucase.c                    | 0
 fs/{cifs => smbfs}/xattr.c                       | 0
 75 files changed, 2 insertions(+), 2 deletions(-)
 rename fs/{cifs => smbfs}/Kconfig (100%)
 rename fs/{cifs => smbfs}/Makefile (100%)
 rename fs/{cifs => smbfs}/asn1.c (100%)
 rename fs/{cifs => smbfs}/cifs_debug.c (100%)
 rename fs/{cifs => smbfs}/cifs_debug.h (100%)
 rename fs/{cifs => smbfs}/cifs_dfs_ref.c (100%)
 rename fs/{cifs => smbfs}/cifs_fs_sb.h (100%)
 rename fs/{cifs => smbfs}/cifs_ioctl.h (100%)
 rename fs/{cifs => smbfs}/cifs_spnego.c (100%)
 rename fs/{cifs => smbfs}/cifs_spnego.h (100%)
 rename fs/{cifs => smbfs}/cifs_spnego_negtokeninit.asn1 (100%)
 rename fs/{cifs => smbfs}/cifs_swn.c (100%)
 rename fs/{cifs => smbfs}/cifs_swn.h (100%)
 rename fs/{cifs => smbfs}/cifs_unicode.c (100%)
 rename fs/{cifs => smbfs}/cifs_unicode.h (100%)
 rename fs/{cifs => smbfs}/cifs_uniupr.h (100%)
 rename fs/{cifs => smbfs}/cifsacl.c (100%)
 rename fs/{cifs => smbfs}/cifsacl.h (100%)
 rename fs/{cifs => smbfs}/cifsencrypt.c (100%)
 rename fs/{cifs => smbfs}/cifsglob.h (100%)
 rename fs/{cifs => smbfs}/cifspdu.h (100%)
 rename fs/{cifs => smbfs}/cifsproto.h (100%)
 rename fs/{cifs => smbfs}/cifsroot.c (100%)
 rename fs/{cifs => smbfs}/cifssmb.c (100%)
 rename fs/{cifs => smbfs}/connect.c (100%)
 rename fs/{cifs => smbfs}/core.c (100%)
 rename fs/{cifs => smbfs}/dfs_cache.c (100%)
 rename fs/{cifs => smbfs}/dfs_cache.h (100%)
 rename fs/{cifs => smbfs}/dir.c (100%)
 rename fs/{cifs => smbfs}/dns_resolve.c (100%)
 rename fs/{cifs => smbfs}/dns_resolve.h (100%)
 rename fs/{cifs => smbfs}/export.c (100%)
 rename fs/{cifs => smbfs}/file.c (100%)
 rename fs/{cifs => smbfs}/fs_context.c (100%)
 rename fs/{cifs => smbfs}/fs_context.h (100%)
 rename fs/{cifs => smbfs}/fscache.c (100%)
 rename fs/{cifs => smbfs}/fscache.h (100%)
 rename fs/{cifs => smbfs}/inode.c (100%)
 rename fs/{cifs => smbfs}/ioctl.c (100%)
 rename fs/{cifs => smbfs}/link.c (100%)
 rename fs/{cifs => smbfs}/misc.c (100%)
 rename fs/{cifs => smbfs}/netlink.c (100%)
 rename fs/{cifs => smbfs}/netlink.h (100%)
 rename fs/{cifs => smbfs}/netmisc.c (100%)
 rename fs/{cifs => smbfs}/nterr.c (100%)
 rename fs/{cifs => smbfs}/nterr.h (100%)
 rename fs/{cifs => smbfs}/ntlmssp.h (100%)
 rename fs/{cifs => smbfs}/readdir.c (100%)
 rename fs/{cifs => smbfs}/rfc1002pdu.h (100%)
 rename fs/{cifs => smbfs}/sess.c (100%)
 rename fs/{cifs => smbfs}/smb1ops.c (100%)
 rename fs/{cifs => smbfs}/smb2file.c (100%)
 rename fs/{cifs => smbfs}/smb2glob.h (100%)
 rename fs/{cifs => smbfs}/smb2inode.c (100%)
 rename fs/{cifs => smbfs}/smb2maperror.c (100%)
 rename fs/{cifs => smbfs}/smb2misc.c (100%)
 rename fs/{cifs => smbfs}/smb2ops.c (100%)
 rename fs/{cifs => smbfs}/smb2pdu.c (100%)
 rename fs/{cifs => smbfs}/smb2pdu.h (100%)
 rename fs/{cifs => smbfs}/smb2proto.h (100%)
 rename fs/{cifs => smbfs}/smb2status.h (100%)
 rename fs/{cifs => smbfs}/smb2transport.c (100%)
 rename fs/{cifs => smbfs}/smbdirect.c (100%)
 rename fs/{cifs => smbfs}/smbdirect.h (100%)
 rename fs/{cifs => smbfs}/smbencrypt.c (100%)
 rename fs/{cifs => smbfs}/smberr.h (100%)
 rename fs/{cifs => smbfs}/smbfs.h (100%)
 rename fs/{cifs => smbfs}/trace.c (100%)
 rename fs/{cifs => smbfs}/trace.h (100%)
 rename fs/{cifs => smbfs}/transport.c (100%)
 rename fs/{cifs => smbfs}/unc.c (100%)
 rename fs/{cifs => smbfs}/winucase.c (100%)
 rename fs/{cifs => smbfs}/xattr.c (100%)

diff --git a/fs/Kconfig b/fs/Kconfig
index 860ca257c681..a069d3b82920 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -372,7 +372,7 @@ config NFS_V4_2_SSC_HELPER
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 
-source "fs/cifs/Kconfig"
+source "fs/smbfs/Kconfig"
 source "fs/ksmbd/Kconfig"
 
 config SMBFS_COMMON
diff --git a/fs/Makefile b/fs/Makefile
index a07039e124ce..dd9ecb89c32a 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -99,7 +99,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-y				+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_SMBFS_COMMON)	+= smbfs_common/
-obj-$(CONFIG_SMBFS)		+= cifs/
+obj-$(CONFIG_SMBFS)		+= smbfs/
 obj-$(CONFIG_SMB_SERVER)	+= ksmbd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
diff --git a/fs/cifs/Kconfig b/fs/smbfs/Kconfig
similarity index 100%
rename from fs/cifs/Kconfig
rename to fs/smbfs/Kconfig
diff --git a/fs/cifs/Makefile b/fs/smbfs/Makefile
similarity index 100%
rename from fs/cifs/Makefile
rename to fs/smbfs/Makefile
diff --git a/fs/cifs/asn1.c b/fs/smbfs/asn1.c
similarity index 100%
rename from fs/cifs/asn1.c
rename to fs/smbfs/asn1.c
diff --git a/fs/cifs/cifs_debug.c b/fs/smbfs/cifs_debug.c
similarity index 100%
rename from fs/cifs/cifs_debug.c
rename to fs/smbfs/cifs_debug.c
diff --git a/fs/cifs/cifs_debug.h b/fs/smbfs/cifs_debug.h
similarity index 100%
rename from fs/cifs/cifs_debug.h
rename to fs/smbfs/cifs_debug.h
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/smbfs/cifs_dfs_ref.c
similarity index 100%
rename from fs/cifs/cifs_dfs_ref.c
rename to fs/smbfs/cifs_dfs_ref.c
diff --git a/fs/cifs/cifs_fs_sb.h b/fs/smbfs/cifs_fs_sb.h
similarity index 100%
rename from fs/cifs/cifs_fs_sb.h
rename to fs/smbfs/cifs_fs_sb.h
diff --git a/fs/cifs/cifs_ioctl.h b/fs/smbfs/cifs_ioctl.h
similarity index 100%
rename from fs/cifs/cifs_ioctl.h
rename to fs/smbfs/cifs_ioctl.h
diff --git a/fs/cifs/cifs_spnego.c b/fs/smbfs/cifs_spnego.c
similarity index 100%
rename from fs/cifs/cifs_spnego.c
rename to fs/smbfs/cifs_spnego.c
diff --git a/fs/cifs/cifs_spnego.h b/fs/smbfs/cifs_spnego.h
similarity index 100%
rename from fs/cifs/cifs_spnego.h
rename to fs/smbfs/cifs_spnego.h
diff --git a/fs/cifs/cifs_spnego_negtokeninit.asn1 b/fs/smbfs/cifs_spnego_negtokeninit.asn1
similarity index 100%
rename from fs/cifs/cifs_spnego_negtokeninit.asn1
rename to fs/smbfs/cifs_spnego_negtokeninit.asn1
diff --git a/fs/cifs/cifs_swn.c b/fs/smbfs/cifs_swn.c
similarity index 100%
rename from fs/cifs/cifs_swn.c
rename to fs/smbfs/cifs_swn.c
diff --git a/fs/cifs/cifs_swn.h b/fs/smbfs/cifs_swn.h
similarity index 100%
rename from fs/cifs/cifs_swn.h
rename to fs/smbfs/cifs_swn.h
diff --git a/fs/cifs/cifs_unicode.c b/fs/smbfs/cifs_unicode.c
similarity index 100%
rename from fs/cifs/cifs_unicode.c
rename to fs/smbfs/cifs_unicode.c
diff --git a/fs/cifs/cifs_unicode.h b/fs/smbfs/cifs_unicode.h
similarity index 100%
rename from fs/cifs/cifs_unicode.h
rename to fs/smbfs/cifs_unicode.h
diff --git a/fs/cifs/cifs_uniupr.h b/fs/smbfs/cifs_uniupr.h
similarity index 100%
rename from fs/cifs/cifs_uniupr.h
rename to fs/smbfs/cifs_uniupr.h
diff --git a/fs/cifs/cifsacl.c b/fs/smbfs/cifsacl.c
similarity index 100%
rename from fs/cifs/cifsacl.c
rename to fs/smbfs/cifsacl.c
diff --git a/fs/cifs/cifsacl.h b/fs/smbfs/cifsacl.h
similarity index 100%
rename from fs/cifs/cifsacl.h
rename to fs/smbfs/cifsacl.h
diff --git a/fs/cifs/cifsencrypt.c b/fs/smbfs/cifsencrypt.c
similarity index 100%
rename from fs/cifs/cifsencrypt.c
rename to fs/smbfs/cifsencrypt.c
diff --git a/fs/cifs/cifsglob.h b/fs/smbfs/cifsglob.h
similarity index 100%
rename from fs/cifs/cifsglob.h
rename to fs/smbfs/cifsglob.h
diff --git a/fs/cifs/cifspdu.h b/fs/smbfs/cifspdu.h
similarity index 100%
rename from fs/cifs/cifspdu.h
rename to fs/smbfs/cifspdu.h
diff --git a/fs/cifs/cifsproto.h b/fs/smbfs/cifsproto.h
similarity index 100%
rename from fs/cifs/cifsproto.h
rename to fs/smbfs/cifsproto.h
diff --git a/fs/cifs/cifsroot.c b/fs/smbfs/cifsroot.c
similarity index 100%
rename from fs/cifs/cifsroot.c
rename to fs/smbfs/cifsroot.c
diff --git a/fs/cifs/cifssmb.c b/fs/smbfs/cifssmb.c
similarity index 100%
rename from fs/cifs/cifssmb.c
rename to fs/smbfs/cifssmb.c
diff --git a/fs/cifs/connect.c b/fs/smbfs/connect.c
similarity index 100%
rename from fs/cifs/connect.c
rename to fs/smbfs/connect.c
diff --git a/fs/cifs/core.c b/fs/smbfs/core.c
similarity index 100%
rename from fs/cifs/core.c
rename to fs/smbfs/core.c
diff --git a/fs/cifs/dfs_cache.c b/fs/smbfs/dfs_cache.c
similarity index 100%
rename from fs/cifs/dfs_cache.c
rename to fs/smbfs/dfs_cache.c
diff --git a/fs/cifs/dfs_cache.h b/fs/smbfs/dfs_cache.h
similarity index 100%
rename from fs/cifs/dfs_cache.h
rename to fs/smbfs/dfs_cache.h
diff --git a/fs/cifs/dir.c b/fs/smbfs/dir.c
similarity index 100%
rename from fs/cifs/dir.c
rename to fs/smbfs/dir.c
diff --git a/fs/cifs/dns_resolve.c b/fs/smbfs/dns_resolve.c
similarity index 100%
rename from fs/cifs/dns_resolve.c
rename to fs/smbfs/dns_resolve.c
diff --git a/fs/cifs/dns_resolve.h b/fs/smbfs/dns_resolve.h
similarity index 100%
rename from fs/cifs/dns_resolve.h
rename to fs/smbfs/dns_resolve.h
diff --git a/fs/cifs/export.c b/fs/smbfs/export.c
similarity index 100%
rename from fs/cifs/export.c
rename to fs/smbfs/export.c
diff --git a/fs/cifs/file.c b/fs/smbfs/file.c
similarity index 100%
rename from fs/cifs/file.c
rename to fs/smbfs/file.c
diff --git a/fs/cifs/fs_context.c b/fs/smbfs/fs_context.c
similarity index 100%
rename from fs/cifs/fs_context.c
rename to fs/smbfs/fs_context.c
diff --git a/fs/cifs/fs_context.h b/fs/smbfs/fs_context.h
similarity index 100%
rename from fs/cifs/fs_context.h
rename to fs/smbfs/fs_context.h
diff --git a/fs/cifs/fscache.c b/fs/smbfs/fscache.c
similarity index 100%
rename from fs/cifs/fscache.c
rename to fs/smbfs/fscache.c
diff --git a/fs/cifs/fscache.h b/fs/smbfs/fscache.h
similarity index 100%
rename from fs/cifs/fscache.h
rename to fs/smbfs/fscache.h
diff --git a/fs/cifs/inode.c b/fs/smbfs/inode.c
similarity index 100%
rename from fs/cifs/inode.c
rename to fs/smbfs/inode.c
diff --git a/fs/cifs/ioctl.c b/fs/smbfs/ioctl.c
similarity index 100%
rename from fs/cifs/ioctl.c
rename to fs/smbfs/ioctl.c
diff --git a/fs/cifs/link.c b/fs/smbfs/link.c
similarity index 100%
rename from fs/cifs/link.c
rename to fs/smbfs/link.c
diff --git a/fs/cifs/misc.c b/fs/smbfs/misc.c
similarity index 100%
rename from fs/cifs/misc.c
rename to fs/smbfs/misc.c
diff --git a/fs/cifs/netlink.c b/fs/smbfs/netlink.c
similarity index 100%
rename from fs/cifs/netlink.c
rename to fs/smbfs/netlink.c
diff --git a/fs/cifs/netlink.h b/fs/smbfs/netlink.h
similarity index 100%
rename from fs/cifs/netlink.h
rename to fs/smbfs/netlink.h
diff --git a/fs/cifs/netmisc.c b/fs/smbfs/netmisc.c
similarity index 100%
rename from fs/cifs/netmisc.c
rename to fs/smbfs/netmisc.c
diff --git a/fs/cifs/nterr.c b/fs/smbfs/nterr.c
similarity index 100%
rename from fs/cifs/nterr.c
rename to fs/smbfs/nterr.c
diff --git a/fs/cifs/nterr.h b/fs/smbfs/nterr.h
similarity index 100%
rename from fs/cifs/nterr.h
rename to fs/smbfs/nterr.h
diff --git a/fs/cifs/ntlmssp.h b/fs/smbfs/ntlmssp.h
similarity index 100%
rename from fs/cifs/ntlmssp.h
rename to fs/smbfs/ntlmssp.h
diff --git a/fs/cifs/readdir.c b/fs/smbfs/readdir.c
similarity index 100%
rename from fs/cifs/readdir.c
rename to fs/smbfs/readdir.c
diff --git a/fs/cifs/rfc1002pdu.h b/fs/smbfs/rfc1002pdu.h
similarity index 100%
rename from fs/cifs/rfc1002pdu.h
rename to fs/smbfs/rfc1002pdu.h
diff --git a/fs/cifs/sess.c b/fs/smbfs/sess.c
similarity index 100%
rename from fs/cifs/sess.c
rename to fs/smbfs/sess.c
diff --git a/fs/cifs/smb1ops.c b/fs/smbfs/smb1ops.c
similarity index 100%
rename from fs/cifs/smb1ops.c
rename to fs/smbfs/smb1ops.c
diff --git a/fs/cifs/smb2file.c b/fs/smbfs/smb2file.c
similarity index 100%
rename from fs/cifs/smb2file.c
rename to fs/smbfs/smb2file.c
diff --git a/fs/cifs/smb2glob.h b/fs/smbfs/smb2glob.h
similarity index 100%
rename from fs/cifs/smb2glob.h
rename to fs/smbfs/smb2glob.h
diff --git a/fs/cifs/smb2inode.c b/fs/smbfs/smb2inode.c
similarity index 100%
rename from fs/cifs/smb2inode.c
rename to fs/smbfs/smb2inode.c
diff --git a/fs/cifs/smb2maperror.c b/fs/smbfs/smb2maperror.c
similarity index 100%
rename from fs/cifs/smb2maperror.c
rename to fs/smbfs/smb2maperror.c
diff --git a/fs/cifs/smb2misc.c b/fs/smbfs/smb2misc.c
similarity index 100%
rename from fs/cifs/smb2misc.c
rename to fs/smbfs/smb2misc.c
diff --git a/fs/cifs/smb2ops.c b/fs/smbfs/smb2ops.c
similarity index 100%
rename from fs/cifs/smb2ops.c
rename to fs/smbfs/smb2ops.c
diff --git a/fs/cifs/smb2pdu.c b/fs/smbfs/smb2pdu.c
similarity index 100%
rename from fs/cifs/smb2pdu.c
rename to fs/smbfs/smb2pdu.c
diff --git a/fs/cifs/smb2pdu.h b/fs/smbfs/smb2pdu.h
similarity index 100%
rename from fs/cifs/smb2pdu.h
rename to fs/smbfs/smb2pdu.h
diff --git a/fs/cifs/smb2proto.h b/fs/smbfs/smb2proto.h
similarity index 100%
rename from fs/cifs/smb2proto.h
rename to fs/smbfs/smb2proto.h
diff --git a/fs/cifs/smb2status.h b/fs/smbfs/smb2status.h
similarity index 100%
rename from fs/cifs/smb2status.h
rename to fs/smbfs/smb2status.h
diff --git a/fs/cifs/smb2transport.c b/fs/smbfs/smb2transport.c
similarity index 100%
rename from fs/cifs/smb2transport.c
rename to fs/smbfs/smb2transport.c
diff --git a/fs/cifs/smbdirect.c b/fs/smbfs/smbdirect.c
similarity index 100%
rename from fs/cifs/smbdirect.c
rename to fs/smbfs/smbdirect.c
diff --git a/fs/cifs/smbdirect.h b/fs/smbfs/smbdirect.h
similarity index 100%
rename from fs/cifs/smbdirect.h
rename to fs/smbfs/smbdirect.h
diff --git a/fs/cifs/smbencrypt.c b/fs/smbfs/smbencrypt.c
similarity index 100%
rename from fs/cifs/smbencrypt.c
rename to fs/smbfs/smbencrypt.c
diff --git a/fs/cifs/smberr.h b/fs/smbfs/smberr.h
similarity index 100%
rename from fs/cifs/smberr.h
rename to fs/smbfs/smberr.h
diff --git a/fs/cifs/smbfs.h b/fs/smbfs/smbfs.h
similarity index 100%
rename from fs/cifs/smbfs.h
rename to fs/smbfs/smbfs.h
diff --git a/fs/cifs/trace.c b/fs/smbfs/trace.c
similarity index 100%
rename from fs/cifs/trace.c
rename to fs/smbfs/trace.c
diff --git a/fs/cifs/trace.h b/fs/smbfs/trace.h
similarity index 100%
rename from fs/cifs/trace.h
rename to fs/smbfs/trace.h
diff --git a/fs/cifs/transport.c b/fs/smbfs/transport.c
similarity index 100%
rename from fs/cifs/transport.c
rename to fs/smbfs/transport.c
diff --git a/fs/cifs/unc.c b/fs/smbfs/unc.c
similarity index 100%
rename from fs/cifs/unc.c
rename to fs/smbfs/unc.c
diff --git a/fs/cifs/winucase.c b/fs/smbfs/winucase.c
similarity index 100%
rename from fs/cifs/winucase.c
rename to fs/smbfs/winucase.c
diff --git a/fs/cifs/xattr.c b/fs/smbfs/xattr.c
similarity index 100%
rename from fs/cifs/xattr.c
rename to fs/smbfs/xattr.c
-- 
2.35.3

