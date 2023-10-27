Return-Path: <linux-fsdevel+bounces-1298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8257D8E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B63B213D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBC8C13;
	Fri, 27 Oct 2023 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAzHAIUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FC8BFB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:03:57 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC0C1AD;
	Thu, 26 Oct 2023 23:03:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d332f23e4so11394786d6.0;
        Thu, 26 Oct 2023 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386635; x=1698991435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd1ycto4mVFRP65nCnRxY/cb/URbObkN/cMQE6EEz18=;
        b=JAzHAIUflXfxLy+RAkhAf906cS2ggAvs/mh+SLmrV61H3KdnPVUR7h4H071/8u47+a
         AThArUpY0jTVQxs5pW5/FR11vb9s4ae/ABE5ciqwzfyrCvygNlVmlIYMyTk0UOHHKRm8
         gPYiBHiZr02+gfbOCjz1ErNsonzadhQfupq/TbC5/TCCin02wnjZlRSCF6aDKCYBYMYo
         BrTLVj4nQMMsjUPBQ0Xy9eqhQV9V0vq7IRmcu0fu7J4HRMsUMkClVNkX0RKPFHxn4THk
         gSvaidaTtr5XB8mQF1DckTfzTR+1l1dsJVr1Yk4oXP0XgtPRnezdI28ne3e81IZNnzac
         aOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386635; x=1698991435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1ycto4mVFRP65nCnRxY/cb/URbObkN/cMQE6EEz18=;
        b=LRirJbq4y0K12ScpUqEDiQL44HYrKmsN7wQ1t7wL5rh0tBjNH/kn5Lus2pQ6es0uMv
         EQDQgelLHWsxgXDanWffXEe9JGVXK9QJZ7eIayp9SELLTSOOTx1z2GiPt8XU6F6lP/Kh
         VkD6oRXvNRlSMOXZOqIWqpxkZlJLdl4wb6QXD0sTXZMpDKhxLXONuqLbWSFWObxEgY8F
         PfUTT8LaMYv5AAnN6+RjH8MCCeIXYLeTtXtzumZZ5pmzYhELQewhmuDo1CbmA7bJzhXu
         EEU8akspPkkmTMZBeOC75o2syIUPTlLXxb6YNqW+4CG/GOQ1iXCsBSrtoHt2byBQIA9u
         UF2A==
X-Gm-Message-State: AOJu0Yy2S+I8pq7JL22qGZn+0oRw1sMYdPUkaocDQptaFLgWBJjaMcPj
	5uX8xINXPVSJKJdnuYxBB/jkgFsIsjqp7ZOTz0c=
X-Google-Smtp-Source: AGHT+IGkLjCDaYZl19jGFLkoUVkIXXVLEBuAIWxYvUsJHEporf8udSq+g7aG9Z9owgySDFa5DH3xyY5kJ+px1ISRe+0=
X-Received: by 2002:a05:6214:ca9:b0:66d:544d:8e68 with SMTP id
 s9-20020a0562140ca900b0066d544d8e68mr2485608qvs.3.1698386635059; Thu, 26 Oct
 2023 23:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026155224.129326-1-amir73il@gmail.com> <ZTtOz8mr1ENl0i9q@infradead.org>
In-Reply-To: <ZTtOz8mr1ENl0i9q@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Oct 2023 09:03:43 +0300
Message-ID: <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 8:46=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> As per the discussion in the last round:
>
> Hard-NAKed-by: Christoph Hellwig <hch@lst.de>
>
> We need to solve the whole btrfs subvolume st_dev thing out properly
> and not leak these details in fanotify.
>

With all due respect, your NACK is uncalled for.

Did you look at the patches?
Did you actually study what they do?
Please point out a single line of code that leaks details to fanotify
as you claim.

The "details" that fanotify reports and has reported since circa v5.1
are the same details available to any unprivileged user via calls
to statfs(2) and name_to_handle_at(2).

The v2 patches do not change anything in that regard.
This is an internal fanotify detail (whether we allow setting a
watch on an inode inside a sub-volume), which does not expose
any new details to usersapce. It has nothing to do with your
campaign to fix the btrfs non-uniform st_dev/f_fsid issue.

Thanks,
Amir.

