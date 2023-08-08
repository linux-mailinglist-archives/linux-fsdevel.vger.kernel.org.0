Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722D773BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjHHPxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHHPv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:51:59 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C347E5246;
        Tue,  8 Aug 2023 08:42:53 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-79aeb0a4665so1606925241.1;
        Tue, 08 Aug 2023 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509026; x=1692113826;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UZdpxVqC4w8SgYwxIIci9xl2Bf47JDQV85VclFbqpI=;
        b=DX05ZENrxsPC/aV+iC0MNe7iC17rhR7d//ZdC/DNe+CI9XBzA08O5aEVkpJ/oXRCdE
         MCFPv1qbb2Fu9V+Be+1YiMon3Lcfc6fVcCTonrk69jJtccvDnnNBFdarsc43UZ7igo3T
         phf8H8WQpO0CfgtzFUnAlTxlykTSAva3e9q9qjZbQ7PCPSrZvhOYYiKK3wAt+uDZw2OV
         WgDcz9Z6yvZG7zR2AS9G8jGhl8eKDVv9JeAlIEUV0/fw99iQquAxSADGBtCJyeQixSrv
         Iu+61fnFId9kIA3pXWrQdMHv15x21aIh5rDPE4Q4x6HAA1uECeW/khJ3F6kEWZFFYYCM
         3Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509026; x=1692113826;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UZdpxVqC4w8SgYwxIIci9xl2Bf47JDQV85VclFbqpI=;
        b=GYp7BtaLovUp7CzNt8XQRE9Bi4EGMZ86WYBEA2zO4n0yxRsBDnKhF9fhv0swEi0nDL
         835W6nzf2nrPSArF/8dzQ4LDJjGoXqzNAn4i7C+yns7UCjQmqdJBdyWBkpGhVoTUy0OY
         2SbwXRUkUol2nJSPUTiCgMxbDjYeZw1JBA7+0bE28bKg85/HZkXm4AADiZM75ZF5nL10
         wGWivsDbMgKNNcatvZb6f6sZAxgecx7KixX+jkc2WF2UF7qcRd/N/3hgkU4jZPfYjKbf
         phqr75+6bwkmehMc0JzecOqf+CCj2QrL5+lDGF93tZpW7woU5uYiI06mP+QCJWz4ATZa
         f8yw==
X-Gm-Message-State: AOJu0YzASlnRz58/Xe2apPkZYzaom3405HQqyX6eketLKC4aKV7GC4nW
        hpDmKOKJBh9JPcy033nHe0M6Kum3Wxqbi4EnnrxA0fKciVs=
X-Google-Smtp-Source: AGHT+IESdVEsqxHWv36mSPE2xSm44bTfNsv0VW30tGUiq1wIqd/3P7m20V/7spsJpfosdCF5KO5qIjyYlfkiZ4d2sFE=
X-Received: by 2002:a4a:918b:0:b0:56d:10bb:c2d2 with SMTP id
 d11-20020a4a918b000000b0056d10bbc2d2mr180377ooh.0.1691507243556; Tue, 08 Aug
 2023 08:07:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:696:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 08:07:22 -0700 (PDT)
In-Reply-To: <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner> <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner> <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 17:07:22 +0200
Message-ID: <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com>
Subject: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I slapped the following variant just for illustration purposes.

- adds __close_fd which returns a struct file
- adds __filp_close with a flag whether to fput
- makes close(2) use both
- transparent to everyone else

Downside is that __fput_sync still loses the assert. Instead of
losing, it could perhaps be extended with a hack to check syscall
number -- pass if either this is close (or binary compat close) or a
kthread, BUG out otherwise. Alternatively perhaps deref could be
opencoded along with a comment about real fput that this is taking
place. Or maybe some other cosmetic choice.

I cannot compile-test right now, so down below is a rough copy make
sure it is clear what I mean.

I feel compelled to note that simple patches get microbenchmarked all
the time, with these results being the only justification provided.
I'm confused why this patch is supposed to be an exception given its
simplicity.

Serious justification should be expected from tough calls --
complicated, invasive changes, maybe with numerous tradeoffs.

In contrast close(2) doing __fput_sync looks a clear cut thing to do,
at worst one can argue which way to do it.

diff --git a/fs/file.c b/fs/file.c
index 3fd003a8604f..c341b07533b0 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -651,20 +651,30 @@ static struct file *pick_file(struct
files_struct *files, unsigned fd)
        return file;
 }

-int close_fd(unsigned fd)
+struct file *__close_fd(unsigned fd, struct file_struct *files)
 {
-       struct files_struct *files = current->files;
        struct file *file;

        spin_lock(&files->file_lock);
        file = pick_file(files, fd);
        spin_unlock(&files->file_lock);
+
+       return file;
+}
+EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
+
+int close_fd(unsigned fd)
+{
+       struct files_struct *files = current->files;
+       struct file *file;
+
+       file = __close_fd(fd, files);
        if (!file)
                return -EBADF;

        return filp_close(file, files);
 }
-EXPORT_SYMBOL(close_fd); /* for ksys_close() */
+EXPORT_SYMBOL(close_fd);

 /**
  * last_fd - return last valid index into fd table
diff --git a/fs/file_table.c b/fs/file_table.c
index fc7d677ff5ad..b7461f0b73f4 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -463,6 +463,11 @@ void __fput_sync(struct file *file)
 {
        if (atomic_long_dec_and_test(&file->f_count)) {
                struct task_struct *task = current;
+               /*
+                * I see 2 basic options
+                * 1. just remove the assert
+                * 2. demand the flag *or* that the caller is close(2)
+                */
                BUG_ON(!(task->flags & PF_KTHREAD));
                __fput(file);
        }
diff --git a/fs/open.c b/fs/open.c
index e6ead0f19964..b1602307c1c3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1533,7 +1533,16 @@ EXPORT_SYMBOL(filp_close);
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-       int retval = close_fd(fd);
+       struct files_struct *files = current->files;
+       struct file *file;
+       int retval;
+
+       file = __close_fd(fd);
+       if (!file)
+               return -EBADF;
+
+       retval = __filp_close(file, files, false);
+       __fput_sync(file);

        /* can't restart close syscall because file table entry was cleared */
        if (unlikely(retval == -ERESTARTSYS ||
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..e64c0238a65f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2388,7 +2388,11 @@ static inline struct file
*file_clone_open(struct file *file)
 {
        return dentry_open(&file->f_path, file->f_flags, file->f_cred);
 }
-extern int filp_close(struct file *, fl_owner_t id);
+extern int __filp_close(struct file *file, fl_owner_t id, bool dofput);
+static inline int filp_close(struct file *file, fl_owner_t id)
+{
+       return __filp_close(file, id, true);
+}

 extern struct filename *getname_flags(const char __user *, int, int *);
 extern struct filename *getname_uflags(const char __user *, int);
