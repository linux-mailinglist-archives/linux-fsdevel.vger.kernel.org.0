Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3AA58822B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHBTBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiHBTBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:01:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F74B4AC;
        Tue,  2 Aug 2022 12:01:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8279320AFE;
        Tue,  2 Aug 2022 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659466860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PestXv0ng72MCyYuHpAzYEGOV/RU4m3zeQXntgBPSmw=;
        b=NFpQGkmoXrNgxRnvJIpsevDY5dLK9KXYyfBQu1xD+/GrsvwgJGIeyXudU7ay4V8E+cZVek
        MIxp0FLOBDnltu8sK7BwiTTQ1c5EE+Sds8q0vOmQLUpuDb8GewRaiBg4AEjixEJUvIVU0B
        9Zlk+UYq19Hvkfqcnx2tbz4tBsid/EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659466860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PestXv0ng72MCyYuHpAzYEGOV/RU4m3zeQXntgBPSmw=;
        b=ubzlFy2PLwOvyJMc5cW1GCz4+ErtUPPrxdfpshjTwstGesUEZcZ75RHwDRE1ejQmBMgfGc
        ZLTr9LIOQCH2nLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 021D713A8E;
        Tue,  2 Aug 2022 19:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uEUaLmt06WLlXwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 02 Aug 2022 19:00:59 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org,
        jlayton@kernel.org, rpenny@samba.org
Subject: [RFC PATCH v2 2/5] smbfs: rename directory "fs/cifs" -> "fs/smb"
Date:   Tue,  2 Aug 2022 16:00:45 -0300
Message-Id: <20220802190048.19881-3-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220802190048.19881-1-ematsumiya@suse.de>
References: <20220802190048.19881-1-ematsumiya@suse.de>
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
 fs/Kconfig                                     | 2 +-
 fs/Makefile                                    | 2 +-
 fs/{cifs => smb}/Kconfig                       | 0
 fs/{cifs => smb}/Makefile                      | 0
 fs/{cifs => smb}/asn1.c                        | 0
 fs/{cifs => smb}/cifs_debug.c                  | 0
 fs/{cifs => smb}/cifs_debug.h                  | 0
 fs/{cifs => smb}/cifs_dfs_ref.c                | 0
 fs/{cifs => smb}/cifs_fs_sb.h                  | 0
 fs/{cifs => smb}/cifs_ioctl.h                  | 0
 fs/{cifs => smb}/cifs_spnego.c                 | 0
 fs/{cifs => smb}/cifs_spnego.h                 | 0
 fs/{cifs => smb}/cifs_spnego_negtokeninit.asn1 | 0
 fs/{cifs => smb}/cifs_swn.c                    | 0
 fs/{cifs => smb}/cifs_swn.h                    | 0
 fs/{cifs => smb}/cifs_unicode.c                | 0
 fs/{cifs => smb}/cifs_unicode.h                | 0
 fs/{cifs => smb}/cifs_uniupr.h                 | 0
 fs/{cifs => smb}/cifsacl.c                     | 0
 fs/{cifs => smb}/cifsacl.h                     | 0
 fs/{cifs => smb}/cifsencrypt.c                 | 0
 fs/{cifs => smb}/cifsglob.h                    | 0
 fs/{cifs => smb}/cifspdu.h                     | 0
 fs/{cifs => smb}/cifsproto.h                   | 0
 fs/{cifs => smb}/cifsroot.c                    | 0
 fs/{cifs => smb}/cifssmb.c                     | 0
 fs/{cifs => smb}/connect.c                     | 0
 fs/{cifs => smb}/core.c                        | 0
 fs/{cifs => smb}/dfs_cache.c                   | 0
 fs/{cifs => smb}/dfs_cache.h                   | 0
 fs/{cifs => smb}/dir.c                         | 0
 fs/{cifs => smb}/dns_resolve.c                 | 0
 fs/{cifs => smb}/dns_resolve.h                 | 0
 fs/{cifs => smb}/export.c                      | 0
 fs/{cifs => smb}/file.c                        | 0
 fs/{cifs => smb}/fs_context.c                  | 0
 fs/{cifs => smb}/fs_context.h                  | 0
 fs/{cifs => smb}/fscache.c                     | 0
 fs/{cifs => smb}/fscache.h                     | 0
 fs/{cifs => smb}/inode.c                       | 0
 fs/{cifs => smb}/ioctl.c                       | 0
 fs/{cifs => smb}/link.c                        | 0
 fs/{cifs => smb}/misc.c                        | 0
 fs/{cifs => smb}/netlink.c                     | 0
 fs/{cifs => smb}/netlink.h                     | 0
 fs/{cifs => smb}/netmisc.c                     | 0
 fs/{cifs => smb}/nterr.c                       | 0
 fs/{cifs => smb}/nterr.h                       | 0
 fs/{cifs => smb}/ntlmssp.h                     | 0
 fs/{cifs => smb}/readdir.c                     | 0
 fs/{cifs => smb}/rfc1002pdu.h                  | 0
 fs/{cifs => smb}/sess.c                        | 0
 fs/{cifs => smb}/smb1ops.c                     | 0
 fs/{cifs => smb}/smb2file.c                    | 0
 fs/{cifs => smb}/smb2glob.h                    | 0
 fs/{cifs => smb}/smb2inode.c                   | 0
 fs/{cifs => smb}/smb2maperror.c                | 0
 fs/{cifs => smb}/smb2misc.c                    | 0
 fs/{cifs => smb}/smb2ops.c                     | 0
 fs/{cifs => smb}/smb2pdu.c                     | 0
 fs/{cifs => smb}/smb2pdu.h                     | 0
 fs/{cifs => smb}/smb2proto.h                   | 0
 fs/{cifs => smb}/smb2status.h                  | 0
 fs/{cifs => smb}/smb2transport.c               | 0
 fs/{cifs => smb}/smbdirect.c                   | 0
 fs/{cifs => smb}/smbdirect.h                   | 0
 fs/{cifs => smb}/smbencrypt.c                  | 0
 fs/{cifs => smb}/smberr.h                      | 0
 fs/{cifs => smb}/smbfs.h                       | 0
 fs/{cifs => smb}/trace.c                       | 0
 fs/{cifs => smb}/trace.h                       | 0
 fs/{cifs => smb}/transport.c                   | 0
 fs/{cifs => smb}/unc.c                         | 0
 fs/{cifs => smb}/winucase.c                    | 0
 fs/{cifs => smb}/xattr.c                       | 0
 75 files changed, 2 insertions(+), 2 deletions(-)
 rename fs/{cifs => smb}/Kconfig (100%)
 rename fs/{cifs => smb}/Makefile (100%)
 rename fs/{cifs => smb}/asn1.c (100%)
 rename fs/{cifs => smb}/cifs_debug.c (100%)
 rename fs/{cifs => smb}/cifs_debug.h (100%)
 rename fs/{cifs => smb}/cifs_dfs_ref.c (100%)
 rename fs/{cifs => smb}/cifs_fs_sb.h (100%)
 rename fs/{cifs => smb}/cifs_ioctl.h (100%)
 rename fs/{cifs => smb}/cifs_spnego.c (100%)
 rename fs/{cifs => smb}/cifs_spnego.h (100%)
 rename fs/{cifs => smb}/cifs_spnego_negtokeninit.asn1 (100%)
 rename fs/{cifs => smb}/cifs_swn.c (100%)
 rename fs/{cifs => smb}/cifs_swn.h (100%)
 rename fs/{cifs => smb}/cifs_unicode.c (100%)
 rename fs/{cifs => smb}/cifs_unicode.h (100%)
 rename fs/{cifs => smb}/cifs_uniupr.h (100%)
 rename fs/{cifs => smb}/cifsacl.c (100%)
 rename fs/{cifs => smb}/cifsacl.h (100%)
 rename fs/{cifs => smb}/cifsencrypt.c (100%)
 rename fs/{cifs => smb}/cifsglob.h (100%)
 rename fs/{cifs => smb}/cifspdu.h (100%)
 rename fs/{cifs => smb}/cifsproto.h (100%)
 rename fs/{cifs => smb}/cifsroot.c (100%)
 rename fs/{cifs => smb}/cifssmb.c (100%)
 rename fs/{cifs => smb}/connect.c (100%)
 rename fs/{cifs => smb}/core.c (100%)
 rename fs/{cifs => smb}/dfs_cache.c (100%)
 rename fs/{cifs => smb}/dfs_cache.h (100%)
 rename fs/{cifs => smb}/dir.c (100%)
 rename fs/{cifs => smb}/dns_resolve.c (100%)
 rename fs/{cifs => smb}/dns_resolve.h (100%)
 rename fs/{cifs => smb}/export.c (100%)
 rename fs/{cifs => smb}/file.c (100%)
 rename fs/{cifs => smb}/fs_context.c (100%)
 rename fs/{cifs => smb}/fs_context.h (100%)
 rename fs/{cifs => smb}/fscache.c (100%)
 rename fs/{cifs => smb}/fscache.h (100%)
 rename fs/{cifs => smb}/inode.c (100%)
 rename fs/{cifs => smb}/ioctl.c (100%)
 rename fs/{cifs => smb}/link.c (100%)
 rename fs/{cifs => smb}/misc.c (100%)
 rename fs/{cifs => smb}/netlink.c (100%)
 rename fs/{cifs => smb}/netlink.h (100%)
 rename fs/{cifs => smb}/netmisc.c (100%)
 rename fs/{cifs => smb}/nterr.c (100%)
 rename fs/{cifs => smb}/nterr.h (100%)
 rename fs/{cifs => smb}/ntlmssp.h (100%)
 rename fs/{cifs => smb}/readdir.c (100%)
 rename fs/{cifs => smb}/rfc1002pdu.h (100%)
 rename fs/{cifs => smb}/sess.c (100%)
 rename fs/{cifs => smb}/smb1ops.c (100%)
 rename fs/{cifs => smb}/smb2file.c (100%)
 rename fs/{cifs => smb}/smb2glob.h (100%)
 rename fs/{cifs => smb}/smb2inode.c (100%)
 rename fs/{cifs => smb}/smb2maperror.c (100%)
 rename fs/{cifs => smb}/smb2misc.c (100%)
 rename fs/{cifs => smb}/smb2ops.c (100%)
 rename fs/{cifs => smb}/smb2pdu.c (100%)
 rename fs/{cifs => smb}/smb2pdu.h (100%)
 rename fs/{cifs => smb}/smb2proto.h (100%)
 rename fs/{cifs => smb}/smb2status.h (100%)
 rename fs/{cifs => smb}/smb2transport.c (100%)
 rename fs/{cifs => smb}/smbdirect.c (100%)
 rename fs/{cifs => smb}/smbdirect.h (100%)
 rename fs/{cifs => smb}/smbencrypt.c (100%)
 rename fs/{cifs => smb}/smberr.h (100%)
 rename fs/{cifs => smb}/smbfs.h (100%)
 rename fs/{cifs => smb}/trace.c (100%)
 rename fs/{cifs => smb}/trace.h (100%)
 rename fs/{cifs => smb}/transport.c (100%)
 rename fs/{cifs => smb}/unc.c (100%)
 rename fs/{cifs => smb}/winucase.c (100%)
 rename fs/{cifs => smb}/xattr.c (100%)

diff --git a/fs/Kconfig b/fs/Kconfig
index 860ca257c681..fe85c87ea990 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -372,7 +372,7 @@ config NFS_V4_2_SSC_HELPER
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 
-source "fs/cifs/Kconfig"
+source "fs/smb/Kconfig"
 source "fs/ksmbd/Kconfig"
 
 config SMBFS_COMMON
diff --git a/fs/Makefile b/fs/Makefile
index a07039e124ce..9d143fb954a7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -99,7 +99,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-y				+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_SMBFS_COMMON)	+= smbfs_common/
-obj-$(CONFIG_SMBFS)		+= cifs/
+obj-$(CONFIG_SMBFS)		+= smb/
 obj-$(CONFIG_SMB_SERVER)	+= ksmbd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
diff --git a/fs/cifs/Kconfig b/fs/smb/Kconfig
similarity index 100%
rename from fs/cifs/Kconfig
rename to fs/smb/Kconfig
diff --git a/fs/cifs/Makefile b/fs/smb/Makefile
similarity index 100%
rename from fs/cifs/Makefile
rename to fs/smb/Makefile
diff --git a/fs/cifs/asn1.c b/fs/smb/asn1.c
similarity index 100%
rename from fs/cifs/asn1.c
rename to fs/smb/asn1.c
diff --git a/fs/cifs/cifs_debug.c b/fs/smb/cifs_debug.c
similarity index 100%
rename from fs/cifs/cifs_debug.c
rename to fs/smb/cifs_debug.c
diff --git a/fs/cifs/cifs_debug.h b/fs/smb/cifs_debug.h
similarity index 100%
rename from fs/cifs/cifs_debug.h
rename to fs/smb/cifs_debug.h
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/smb/cifs_dfs_ref.c
similarity index 100%
rename from fs/cifs/cifs_dfs_ref.c
rename to fs/smb/cifs_dfs_ref.c
diff --git a/fs/cifs/cifs_fs_sb.h b/fs/smb/cifs_fs_sb.h
similarity index 100%
rename from fs/cifs/cifs_fs_sb.h
rename to fs/smb/cifs_fs_sb.h
diff --git a/fs/cifs/cifs_ioctl.h b/fs/smb/cifs_ioctl.h
similarity index 100%
rename from fs/cifs/cifs_ioctl.h
rename to fs/smb/cifs_ioctl.h
diff --git a/fs/cifs/cifs_spnego.c b/fs/smb/cifs_spnego.c
similarity index 100%
rename from fs/cifs/cifs_spnego.c
rename to fs/smb/cifs_spnego.c
diff --git a/fs/cifs/cifs_spnego.h b/fs/smb/cifs_spnego.h
similarity index 100%
rename from fs/cifs/cifs_spnego.h
rename to fs/smb/cifs_spnego.h
diff --git a/fs/cifs/cifs_spnego_negtokeninit.asn1 b/fs/smb/cifs_spnego_negtokeninit.asn1
similarity index 100%
rename from fs/cifs/cifs_spnego_negtokeninit.asn1
rename to fs/smb/cifs_spnego_negtokeninit.asn1
diff --git a/fs/cifs/cifs_swn.c b/fs/smb/cifs_swn.c
similarity index 100%
rename from fs/cifs/cifs_swn.c
rename to fs/smb/cifs_swn.c
diff --git a/fs/cifs/cifs_swn.h b/fs/smb/cifs_swn.h
similarity index 100%
rename from fs/cifs/cifs_swn.h
rename to fs/smb/cifs_swn.h
diff --git a/fs/cifs/cifs_unicode.c b/fs/smb/cifs_unicode.c
similarity index 100%
rename from fs/cifs/cifs_unicode.c
rename to fs/smb/cifs_unicode.c
diff --git a/fs/cifs/cifs_unicode.h b/fs/smb/cifs_unicode.h
similarity index 100%
rename from fs/cifs/cifs_unicode.h
rename to fs/smb/cifs_unicode.h
diff --git a/fs/cifs/cifs_uniupr.h b/fs/smb/cifs_uniupr.h
similarity index 100%
rename from fs/cifs/cifs_uniupr.h
rename to fs/smb/cifs_uniupr.h
diff --git a/fs/cifs/cifsacl.c b/fs/smb/cifsacl.c
similarity index 100%
rename from fs/cifs/cifsacl.c
rename to fs/smb/cifsacl.c
diff --git a/fs/cifs/cifsacl.h b/fs/smb/cifsacl.h
similarity index 100%
rename from fs/cifs/cifsacl.h
rename to fs/smb/cifsacl.h
diff --git a/fs/cifs/cifsencrypt.c b/fs/smb/cifsencrypt.c
similarity index 100%
rename from fs/cifs/cifsencrypt.c
rename to fs/smb/cifsencrypt.c
diff --git a/fs/cifs/cifsglob.h b/fs/smb/cifsglob.h
similarity index 100%
rename from fs/cifs/cifsglob.h
rename to fs/smb/cifsglob.h
diff --git a/fs/cifs/cifspdu.h b/fs/smb/cifspdu.h
similarity index 100%
rename from fs/cifs/cifspdu.h
rename to fs/smb/cifspdu.h
diff --git a/fs/cifs/cifsproto.h b/fs/smb/cifsproto.h
similarity index 100%
rename from fs/cifs/cifsproto.h
rename to fs/smb/cifsproto.h
diff --git a/fs/cifs/cifsroot.c b/fs/smb/cifsroot.c
similarity index 100%
rename from fs/cifs/cifsroot.c
rename to fs/smb/cifsroot.c
diff --git a/fs/cifs/cifssmb.c b/fs/smb/cifssmb.c
similarity index 100%
rename from fs/cifs/cifssmb.c
rename to fs/smb/cifssmb.c
diff --git a/fs/cifs/connect.c b/fs/smb/connect.c
similarity index 100%
rename from fs/cifs/connect.c
rename to fs/smb/connect.c
diff --git a/fs/cifs/core.c b/fs/smb/core.c
similarity index 100%
rename from fs/cifs/core.c
rename to fs/smb/core.c
diff --git a/fs/cifs/dfs_cache.c b/fs/smb/dfs_cache.c
similarity index 100%
rename from fs/cifs/dfs_cache.c
rename to fs/smb/dfs_cache.c
diff --git a/fs/cifs/dfs_cache.h b/fs/smb/dfs_cache.h
similarity index 100%
rename from fs/cifs/dfs_cache.h
rename to fs/smb/dfs_cache.h
diff --git a/fs/cifs/dir.c b/fs/smb/dir.c
similarity index 100%
rename from fs/cifs/dir.c
rename to fs/smb/dir.c
diff --git a/fs/cifs/dns_resolve.c b/fs/smb/dns_resolve.c
similarity index 100%
rename from fs/cifs/dns_resolve.c
rename to fs/smb/dns_resolve.c
diff --git a/fs/cifs/dns_resolve.h b/fs/smb/dns_resolve.h
similarity index 100%
rename from fs/cifs/dns_resolve.h
rename to fs/smb/dns_resolve.h
diff --git a/fs/cifs/export.c b/fs/smb/export.c
similarity index 100%
rename from fs/cifs/export.c
rename to fs/smb/export.c
diff --git a/fs/cifs/file.c b/fs/smb/file.c
similarity index 100%
rename from fs/cifs/file.c
rename to fs/smb/file.c
diff --git a/fs/cifs/fs_context.c b/fs/smb/fs_context.c
similarity index 100%
rename from fs/cifs/fs_context.c
rename to fs/smb/fs_context.c
diff --git a/fs/cifs/fs_context.h b/fs/smb/fs_context.h
similarity index 100%
rename from fs/cifs/fs_context.h
rename to fs/smb/fs_context.h
diff --git a/fs/cifs/fscache.c b/fs/smb/fscache.c
similarity index 100%
rename from fs/cifs/fscache.c
rename to fs/smb/fscache.c
diff --git a/fs/cifs/fscache.h b/fs/smb/fscache.h
similarity index 100%
rename from fs/cifs/fscache.h
rename to fs/smb/fscache.h
diff --git a/fs/cifs/inode.c b/fs/smb/inode.c
similarity index 100%
rename from fs/cifs/inode.c
rename to fs/smb/inode.c
diff --git a/fs/cifs/ioctl.c b/fs/smb/ioctl.c
similarity index 100%
rename from fs/cifs/ioctl.c
rename to fs/smb/ioctl.c
diff --git a/fs/cifs/link.c b/fs/smb/link.c
similarity index 100%
rename from fs/cifs/link.c
rename to fs/smb/link.c
diff --git a/fs/cifs/misc.c b/fs/smb/misc.c
similarity index 100%
rename from fs/cifs/misc.c
rename to fs/smb/misc.c
diff --git a/fs/cifs/netlink.c b/fs/smb/netlink.c
similarity index 100%
rename from fs/cifs/netlink.c
rename to fs/smb/netlink.c
diff --git a/fs/cifs/netlink.h b/fs/smb/netlink.h
similarity index 100%
rename from fs/cifs/netlink.h
rename to fs/smb/netlink.h
diff --git a/fs/cifs/netmisc.c b/fs/smb/netmisc.c
similarity index 100%
rename from fs/cifs/netmisc.c
rename to fs/smb/netmisc.c
diff --git a/fs/cifs/nterr.c b/fs/smb/nterr.c
similarity index 100%
rename from fs/cifs/nterr.c
rename to fs/smb/nterr.c
diff --git a/fs/cifs/nterr.h b/fs/smb/nterr.h
similarity index 100%
rename from fs/cifs/nterr.h
rename to fs/smb/nterr.h
diff --git a/fs/cifs/ntlmssp.h b/fs/smb/ntlmssp.h
similarity index 100%
rename from fs/cifs/ntlmssp.h
rename to fs/smb/ntlmssp.h
diff --git a/fs/cifs/readdir.c b/fs/smb/readdir.c
similarity index 100%
rename from fs/cifs/readdir.c
rename to fs/smb/readdir.c
diff --git a/fs/cifs/rfc1002pdu.h b/fs/smb/rfc1002pdu.h
similarity index 100%
rename from fs/cifs/rfc1002pdu.h
rename to fs/smb/rfc1002pdu.h
diff --git a/fs/cifs/sess.c b/fs/smb/sess.c
similarity index 100%
rename from fs/cifs/sess.c
rename to fs/smb/sess.c
diff --git a/fs/cifs/smb1ops.c b/fs/smb/smb1ops.c
similarity index 100%
rename from fs/cifs/smb1ops.c
rename to fs/smb/smb1ops.c
diff --git a/fs/cifs/smb2file.c b/fs/smb/smb2file.c
similarity index 100%
rename from fs/cifs/smb2file.c
rename to fs/smb/smb2file.c
diff --git a/fs/cifs/smb2glob.h b/fs/smb/smb2glob.h
similarity index 100%
rename from fs/cifs/smb2glob.h
rename to fs/smb/smb2glob.h
diff --git a/fs/cifs/smb2inode.c b/fs/smb/smb2inode.c
similarity index 100%
rename from fs/cifs/smb2inode.c
rename to fs/smb/smb2inode.c
diff --git a/fs/cifs/smb2maperror.c b/fs/smb/smb2maperror.c
similarity index 100%
rename from fs/cifs/smb2maperror.c
rename to fs/smb/smb2maperror.c
diff --git a/fs/cifs/smb2misc.c b/fs/smb/smb2misc.c
similarity index 100%
rename from fs/cifs/smb2misc.c
rename to fs/smb/smb2misc.c
diff --git a/fs/cifs/smb2ops.c b/fs/smb/smb2ops.c
similarity index 100%
rename from fs/cifs/smb2ops.c
rename to fs/smb/smb2ops.c
diff --git a/fs/cifs/smb2pdu.c b/fs/smb/smb2pdu.c
similarity index 100%
rename from fs/cifs/smb2pdu.c
rename to fs/smb/smb2pdu.c
diff --git a/fs/cifs/smb2pdu.h b/fs/smb/smb2pdu.h
similarity index 100%
rename from fs/cifs/smb2pdu.h
rename to fs/smb/smb2pdu.h
diff --git a/fs/cifs/smb2proto.h b/fs/smb/smb2proto.h
similarity index 100%
rename from fs/cifs/smb2proto.h
rename to fs/smb/smb2proto.h
diff --git a/fs/cifs/smb2status.h b/fs/smb/smb2status.h
similarity index 100%
rename from fs/cifs/smb2status.h
rename to fs/smb/smb2status.h
diff --git a/fs/cifs/smb2transport.c b/fs/smb/smb2transport.c
similarity index 100%
rename from fs/cifs/smb2transport.c
rename to fs/smb/smb2transport.c
diff --git a/fs/cifs/smbdirect.c b/fs/smb/smbdirect.c
similarity index 100%
rename from fs/cifs/smbdirect.c
rename to fs/smb/smbdirect.c
diff --git a/fs/cifs/smbdirect.h b/fs/smb/smbdirect.h
similarity index 100%
rename from fs/cifs/smbdirect.h
rename to fs/smb/smbdirect.h
diff --git a/fs/cifs/smbencrypt.c b/fs/smb/smbencrypt.c
similarity index 100%
rename from fs/cifs/smbencrypt.c
rename to fs/smb/smbencrypt.c
diff --git a/fs/cifs/smberr.h b/fs/smb/smberr.h
similarity index 100%
rename from fs/cifs/smberr.h
rename to fs/smb/smberr.h
diff --git a/fs/cifs/smbfs.h b/fs/smb/smbfs.h
similarity index 100%
rename from fs/cifs/smbfs.h
rename to fs/smb/smbfs.h
diff --git a/fs/cifs/trace.c b/fs/smb/trace.c
similarity index 100%
rename from fs/cifs/trace.c
rename to fs/smb/trace.c
diff --git a/fs/cifs/trace.h b/fs/smb/trace.h
similarity index 100%
rename from fs/cifs/trace.h
rename to fs/smb/trace.h
diff --git a/fs/cifs/transport.c b/fs/smb/transport.c
similarity index 100%
rename from fs/cifs/transport.c
rename to fs/smb/transport.c
diff --git a/fs/cifs/unc.c b/fs/smb/unc.c
similarity index 100%
rename from fs/cifs/unc.c
rename to fs/smb/unc.c
diff --git a/fs/cifs/winucase.c b/fs/smb/winucase.c
similarity index 100%
rename from fs/cifs/winucase.c
rename to fs/smb/winucase.c
diff --git a/fs/cifs/xattr.c b/fs/smb/xattr.c
similarity index 100%
rename from fs/cifs/xattr.c
rename to fs/smb/xattr.c
-- 
2.35.3

