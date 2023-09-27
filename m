Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E07B07AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjI0PIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjI0PIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:08:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8B5F4;
        Wed, 27 Sep 2023 08:08:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE700C433C8;
        Wed, 27 Sep 2023 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827332;
        bh=rVJ3mC+n/SWejnI1i+ge/9fNDBh8INviovzGEmpuCQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdhqwJM9IvrABPs00ahx0ck9XgmygnDQX1cG1z7uMeIHU49TstmxhFwfVThmw0Ki4
         ju7moZfFlQxvuJ2S3oA2MJI6+SgLZi5LCT0k7frw2YEH0nzqulZNoNabRmH8QWoZAt
         SGmuKKTQooxbJMXmD6vEgDTp2uZHCpztJi/sJUkArw+ynY5BpUfmauWsEhYkpu8hKB
         SvxCC/VcS0/QXjzLHOzdMvf68jIEBDx1gtUTlejOLEQ0ZkToIydyKqdrvaRt3w+9OG
         RXD4mI19eofbAbTLWjL6VQyA/bTopiOa9GwttMfgUAeJoTiFg6bV4wQ3BL27a+AHyh
         6+F2OgysjfUxw==
Date:   Wed, 27 Sep 2023 17:08:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in
 ntfs_write_bh
Message-ID: <20230927-armaturen-bestochen-e438ec36aa99@brauner>
References: <0000000000006777d506051db4fd@google.com>
 <000000000000553a2106064e3d86@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000553a2106064e3d86@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz fix: ntfs3: put resources during ntfs_fill_super()
