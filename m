Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D416CA2E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 13:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjC0Lyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 07:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Lyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:54:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB723595;
        Mon, 27 Mar 2023 04:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01951B81116;
        Mon, 27 Mar 2023 11:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D51C433EF;
        Mon, 27 Mar 2023 11:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679918087;
        bh=cx5vKI/ygapCQHMUJQtB0SDRpCRJAmHk+8n3arL1sPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htnJslidLiwhm5BRGlFi/1Rd07JYW0gSph998eLUjbwgGnaKBsWBPIIlP1IXJ7zMw
         sf9wVe4tz4eJC8JnM2f+jVj6HRWMxZ60WE/Ttk+fsnzRIPYwov6JNNrTjGe9324KQr
         M0qGj+/bjgD7WdjEU4UADNfXrRBdkJBxfZN+xe6+/FHmllfbJsVCDE+jNB22FzeN0v
         mmb8iML6SSz6QUwGPkveifEtyuzphTN0eRPI9WIFJL69j1G+cuKZVbOtfvZl5WU+u6
         85guMRYy1zpKMI1FG5gAnFzffJZdXwqmRQhkB5f+Y9gxJPi4DAq8RgH0+p1DbrtJHU
         u3prtLEh4kxOw==
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update relatime comments to include equality
Date:   Mon, 27 Mar 2023 13:54:37 +0200
Message-Id: <167991793868.1703100.49513335049030523.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230325082232.2017437-1-steve@sk2.org>
References: <20230325082232.2017437-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=brauner@kernel.org; h=from:subject:message-id; bh=VkKmONLeacXghE/+OSQuqF8ac8wcW+WUUVla2l6udEc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQoNv8I3HKe6/C97az8m9aKxoiet1rlGPOxfGn4sgC9p9st Xh/l6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI61+G/0EKE4oWZN8K2sLJ7sPM8C rAP+BmqU7z5xUC2o5neDibvBn+x/J9SNNckd9V5CFmupDpcvbM+hkrz504WDDh+3aHBzp8vAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Sat, 25 Mar 2023 09:22:32 +0100, Stephen Kitt wrote:
> relatime also updates atime if the previous atime is equal to one or
> both of the ctime and mtime; a non-strict interpretation of "earlier
> than" and "younger than" in the comments allows this, but for clarity,
> this makes it explicit.
> 
> Pointed out by "epiii2" and "ctrl-alt-delor" in
> https://unix.stackexchange.com/q/740862/86440.
> 
> [...]

Seems userspace documentation has been update accordingly. So looks good to me,

tree: https://lore.kernel.org/lkml/20230325082232.2017437-1-steve@sk2.org
branch: fs.misc
[1/1] Update relatime comments to include equality
      commit: d98ffa1aca264ce547b9135135f83d81cfe4345f

Thanks!
Christian
