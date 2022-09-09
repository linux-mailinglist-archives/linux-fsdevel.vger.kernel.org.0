Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34B5B37E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiIIMem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiIIMeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:34:23 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 137B0144953
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 05:33:38 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 863732003FB8;
        Fri,  9 Sep 2022 21:33:13 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 289CXCWM029596
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 21:33:13 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 289CXCWt059138
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 21:33:12 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 289CXCTt059137;
        Fri, 9 Sep 2022 21:33:12 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
In-Reply-To: <20220909102656.pqlipjit2zlp4vdx@wittgenstein> (Christian
        Brauner's message of "Fri, 9 Sep 2022 12:26:56 +0200")
References: <20220909093019.936863-1-brauner@kernel.org>
        <87czc4rhng.fsf@mail.parknet.co.jp>
        <20220909102656.pqlipjit2zlp4vdx@wittgenstein>
Date:   Fri, 09 Sep 2022 21:33:12 +0900
Message-ID: <878rmsralz.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Sep 09, 2022 at 07:01:07PM +0900, OGAWA Hirofumi wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>> 
>> > A while ago we introduced a dedicated vfs{g,u}id_t type in commit
>> > 1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
>> > over a good part of the VFS. Ultimately we will remove all legacy
>> > idmapped mount helpers that operate only on k{g,u}id_t in favor of the
>> > new type safe helpers that operate on vfs{g,u}id_t.
>> 
>> If consistent with other parts in kernel, looks good.
>> 
>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Just to make sure: will you be taking this patch yourself or should I?

Ah, I was expecting almost all convert patches goes at once via you or
vfs git.  However, if you want this goes via me, please let me know.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
