Return-Path: <linux-fsdevel+bounces-876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B97D1E5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1683AB21274
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD9DDB9;
	Sat, 21 Oct 2023 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dTP1n71r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A163D
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 16:47:01 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C81A8
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 09:46:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2762020a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697906815; x=1698511615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OSjTUcgTd18PHEYhijTK/4fWY0j7UY3vKA/ggDHvC6g=;
        b=dTP1n71rDU+s5s6eyJqPOKZoGZfY4RQ2vNq3HbB9Clx/2szD6ZFQUohgW+DjkXQWB8
         dfFTVK9ABw8nuX2Lz3X6mHrR5G/XCQs4D4lTXs0794SplLsfgkj+D77t2OoHPn8ccUE/
         mEgIka471CJLyB0rv+T0y2bbfblpVKj4NmHZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697906815; x=1698511615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSjTUcgTd18PHEYhijTK/4fWY0j7UY3vKA/ggDHvC6g=;
        b=MrNH5I6uI3p4bRhpJixkCqAzlO4ThCy/zlasPRg8M/cllazxdbCxc2yKKMnQdyhb49
         3Q88o6BLrXxsGT0vXjqq4Oxu5D1cld7QZXRtJ+gZYZLpX/dG8Yg5ak1StKLVmAxm3O5i
         +6l+p0DTMldaQuyYUl3xbto2lGcXqPtzjYYbfIGE8v5loBrK6Bj0A6diHQts2JwnfT9j
         zwhIR++M/l+oEnvlTIZmPBN6DiNlN/qygHoi5ubEcbkkL7PR5EDuOAYg7Wl7+uy+WIVw
         xk3ZjqWK+CGQE4Yv8JX/IT8uGfzDAwas1NRPbd9YES4Lx8RkylMBGglhtY5wxPD2STl2
         d0hg==
X-Gm-Message-State: AOJu0YzGRIhfomS7ljIF20AhXTrJ1GLezReGM07nrqwQFyoMHrhkOqTZ
	GKnyNL4yg3BSWpZBL0OAZfMBB5KpPbZi8bRPc+ew+5lW
X-Google-Smtp-Source: AGHT+IHVAmeyXbSK4lmauz0SEsWWujFkD88AxtPeWZ2ZGKcZ4pYFwZ5n6Y4Bp/EUSEbzohmOlsdbDQ==
X-Received: by 2002:a50:bb44:0:b0:53e:5f9:328b with SMTP id y62-20020a50bb44000000b0053e05f9328bmr3220398ede.2.1697906815362;
        Sat, 21 Oct 2023 09:46:55 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id bt15-20020a0564020a4f00b0053e0f63ce33sm3614092edb.95.2023.10.21.09.46.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 09:46:54 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2762002a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 09:46:54 -0700 (PDT)
X-Received: by 2002:a50:c30a:0:b0:53d:b2c8:6783 with SMTP id
 a10-20020a50c30a000000b0053db2c86783mr3094776edb.14.1697906813973; Sat, 21
 Oct 2023 09:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
In-Reply-To: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Oct 2023 09:46:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
Message-ID: <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, jstancek@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 23:27, Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please pull this branch with changes for iomap for 6.6-rc7.
>
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.

.. and as usual, the branch you point to does not actually exist.

Because you *again* pointed to the wrong tree.

This time I remembered what the mistake was last time, and picked out
the right tree by hand, but *please* just fix your completely broken
scripts or workflow.

> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5

No.

It's pub/scm/fs/xfs/xfs-linux, once again.

                 Linus

