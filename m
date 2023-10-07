Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754A97BC510
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjJGGhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 02:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJGGhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:37:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711FBBF;
        Fri,  6 Oct 2023 23:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECD5C433C7;
        Sat,  7 Oct 2023 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696660658;
        bh=KSOrew3wseS+vBwOvbuWsGImKQGR9H+tyoy0Z79qIxY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VpiywC3o4HFOAQeLLKHx6ezYJX/OqNZR0whHK8AUlqUZcOcPGcsKShE7YmKGKLzl+
         AjI8+oqtE0G7WZbGe4ciaN3d+D7ry55pvoLNmA6xuz9hTnPdzj305JAlcxbfwoiJRB
         TTNu14qcH97j7vH02yN7hesuv46VGki7tmefSa5Q2+cwOkchrXm3ePAwfhr5/W5kuB
         no58BpfveTcEdTB1IsSYeATlJEy0dXDGZEBVFZU47OP1LSIq+VuQGGaP60bQ5tfgUN
         NCqJDEBbRHvUi9wBdgMDFz1CJTDkIyVjlfuA+CjhjyvpmJf4qxsV4BmkVxq2PVuzbn
         QSdQeXdvkzMig==
Message-ID: <3c154d90-f9ab-e0e9-dd49-d6880a45763f@kernel.org>
Date:   Sat, 7 Oct 2023 14:37:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/29] f2fs: move f2fs_xattr_handlers and
 f2fs_xattr_handler_map to .rodata
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-11-wedsonaf@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230930050033.41174-11-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/9/30 13:00, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> f2fs_xattr_handlers or f2fs_xattr_handler_map at runtime.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
