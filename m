Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1347C63CA31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 22:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiK2VMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 16:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiK2VMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:12:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746CF1571C;
        Tue, 29 Nov 2022 13:12:26 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCKCP029753
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756341; bh=hN52RjOfTkMQfqLYDqY+v8NwHQOagcV94TMMkIz/n1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RmvgyoohS4wxrf9qyuu8o61Zm4yG/7W8XaR8F1t60LYXfE5qrEN09o4ldXXJGOv5k
         M3cS8dMmerDWuVKKmSjAlJYth3Iywj7W43T2iJZYGZE8OuzYRzMkY/ZrgDO5rqWUsL
         NDjgsjWR+FDmZNk+7vzhkX0rzbTRKh9dI94OGS/eUvvfJqTOYep2vim9Q6KcMDSk0h
         dmz8VjOBZzKQKjsBDkkaSYec5LmaKhlMEk+pB/BcmIxcOkKfKqGy1boPK5oXJyZQza
         yb2AiozgGJ42+d97tiVSKKsIs9IvZLqIf3G5XRu+d2vu/otAHkj4VbUfi7qRybV+nJ
         S7PHEQStW7IIw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6803A15C3AB2; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: journal_path mount options should follow links
Date:   Tue, 29 Nov 2022 16:12:12 -0500
Message-Id: <166975630695.2135297.10509111299915561694.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221004135803.32283-1-lczerner@redhat.com>
References: <20221004135803.32283-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Oct 2022 15:58:03 +0200, Lukas Czerner wrote:
> Before the commit 461c3af045d3 ("ext4: Change handle_mount_opt() to use
> fs_parameter") ext4 mount option journal_path did follow links in the
> provided path.
> 
> Bring this behavior back by allowing to pass pathwalk flags to
> fs_lookup_param().
> 
> [...]

Applied, thanks!

[1/1] ext4: journal_path mount options should follow links
      commit: c5d6c14eac604c4ef551e2751726f665b3f09e32

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
