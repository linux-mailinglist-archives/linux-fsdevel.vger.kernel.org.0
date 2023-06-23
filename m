Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B273BA7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjFWOod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFWOoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C42710
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 07:43:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a33c35b1so10670757b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531425; x=1690123425;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzVf4AQ2Gj+vEw9k0OpeO1MnttP8JRzBxK8284Th/Bs=;
        b=Rz5mgT4t49UyyDXzm7g/diB2I5T3vJPW+XLqYYgq1VHa8Ft9nKOc7ri3YoHMXsYOhL
         F7kSW9wSNEWe8BEIleC+ZdwGAeE+zVvdOVXxl26FTioHggOFiFVSp396I8xJgO76VBB4
         05knMdp8g3p2lxXlevvRuha8DaJ1mx8V+A9oIZh59e7rD3A9zyqy3fV4LWRRwTQLMkqX
         pOgPgJpVlDRYSGWWa18nAaZqY+sBmL283PQMvbQ04lQF3MZBu2CajuRmuHcpE36EjsZ4
         e6b60gddjQv2U95AXgXS6kdGDz8yJh3PhYnsmmRjlKOtkWrsUWcIwb5AVTTSiC+0zrzN
         RtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531425; x=1690123425;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UzVf4AQ2Gj+vEw9k0OpeO1MnttP8JRzBxK8284Th/Bs=;
        b=MtVmPQPp6U3KfPrWTuXlt+Nx4igvjnZvX5urkiQiYnrXnWP55x1L3xTxAtCTTKJajX
         U9UQzfcdeisEHiaUzL3a+8NdxU2lL+7Mg5mj/jXbqC281adSUEFg2Xq6vXmS0MSkzlRv
         pKeZlnzS8cF5JBDkNxBVwJzhyYCg7+pM5wHZJLd/+u7QzfZPUi/D1PDrbQGs2FJegA7p
         x00XaqWmyreqomJQw4FzBRHsEvlhuVcSmh5zfgDmdyyBKO59gMAzcjhbF/I9F1lligav
         QqAUTmI3+2n1p4ycgzILMgG8hB4oR0KXntP76gX4wDh+t6abBOHHUT5R9c8tdNYOn46v
         7hSg==
X-Gm-Message-State: AC+VfDw7rSc3Yp9MKTaqRcAmh6zX4G30dgye6tVTZNXu+TbQfP/xgSQJ
        fLrpYx1BSRiFpLnTXxiAfzRa+MRSvZk=
X-Google-Smtp-Source: ACHHUZ5L1Rbyg5OV+PIAv1YSaAvjSV37tCLvlzItTQR5LJBllU3DnqDdfuYMp/9i72ghGwmqJMPeNPRq05Y=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a81:ca0c:0:b0:559:e97a:cb21 with SMTP id
 p12-20020a81ca0c000000b00559e97acb21mr8800943ywi.9.1687531425115; Fri, 23 Jun
 2023 07:43:45 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:26 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <20230623144329.136541-4-gnoack@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 3/6] selftests/landlock: Test ioctl support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Exercise the use of Landlock's ioctl restriction: If ioctl is
restricted, the use of ioctl fails with a freshly opened /dev/tty
file.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 09dd1eaac8a9..0f0899768fe7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3732,6 +3732,68 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * Invokes ioctl(2) and returns its errno or 0.
+ * The provided fd needs to be a tty for this to work.
+ */
+static int test_tty_ioctl(int fd)
+{
+	struct winsize ws;
+
+	if (ioctl(fd, TIOCGWINSZ, &ws) < 0)
+		return errno;
+	return 0;
+}
+
+/*
+ * Attempt ioctl on /dev/tty0 and /dev/tty1,
+ * with file descriptors opened before and after landlocking.
+ */
+TEST_F_FORK(layout0, ioctl)
+{
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev/tty1",
+			.access =3D LANDLOCK_ACCESS_FS_IOCTL,
+		},
+		/* Implicitly: No ioctl access on /dev/tty0. */
+		{},
+	};
+	const __u64 handled =3D LANDLOCK_ACCESS_FS_IOCTL;
+	int ruleset_fd;
+	int old_tty0_fd, tty0_fd, tty1_fd;
+
+	old_tty0_fd =3D open("/dev/tty0", O_RDWR);
+	ASSERT_LE(0, old_tty0_fd);
+
+	/* Checks that ioctl works before landlocking. */
+	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
+
+	/* Enable Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that ioctl with existing FD works after landlocking. */
+	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
+
+	/* Checks that same ioctl fails when file is opened after landlocking. */
+	tty0_fd =3D open("/dev/tty0", O_RDWR);
+	ASSERT_LE(0, tty0_fd);
+	EXPECT_EQ(EACCES, test_tty_ioctl(tty0_fd));
+
+	/* Checks that same ioctl fails when file is opened after landlocking. */
+	tty1_fd =3D open("/dev/tty1", O_RDWR);
+	ASSERT_LE(0, tty1_fd);
+	EXPECT_EQ(0, test_tty_ioctl(tty1_fd));
+
+	/* Close all TTY file descriptors. */
+	ASSERT_EQ(0, close(old_tty0_fd));
+	ASSERT_EQ(0, close(tty0_fd));
+	ASSERT_EQ(0, close(tty1_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.41.0.162.gfafddb0af9-goog

