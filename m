Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002A678F05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjAXDfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjAXDfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:35:18 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339492BF09;
        Mon, 23 Jan 2023 19:35:17 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id p1so15201702vsr.5;
        Mon, 23 Jan 2023 19:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KeZ9BYuTNP3d0+LoqPUUo8cuwmoRUwHY0k9GjFpzbGM=;
        b=heZKBaZy5CFwNydSjMbuA91DnnsEWcpjsJJHiRbwYNKMY1H7kpiRDVq4bVPoEorFAl
         0gKsOiFoFiSKNoav2udW7ADnwM5aLoo/5WvYpUEewv78+b28m/o6xtfE5vWqdgZeebbl
         wUXfrErIU0hSPPNHieArpkP39rDg1pJ+tFE6AB0zpZW4et1f6ZySlH8zYpJtG3Mo0Z3Z
         n0LIDiDJJRDIP+hhd4y7W9Dsx4EVCOf4zaKkowPujlcXrHdQlpBquRdmKBHuitChlOhO
         v3ugOfJvcx1wYexVsRHk0ohjqKbFWFSQYZLYG5jLMJ5Q5qKxemP8p13NI5upBcHTxUYQ
         +Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeZ9BYuTNP3d0+LoqPUUo8cuwmoRUwHY0k9GjFpzbGM=;
        b=1ReMHWZjXu5CMtwf63eNO2586mROOGHKJxG+5uw1MakvRUs5lGNBh6fL6GHX9vEYU8
         44sKB6+Kzh+vVwwLIfZHm6e/zj3S94+Vr5IbIDMiYQOHyqQLnATdj82hNIYEY6wCewjL
         ffzXuJQA3QCA5xIhwlc34TflN0bM9Io5QPa/2Wma26A+utMHGL1YSHxNzpW5A24upEQ6
         ARlIwcewHtnU1To7WkXKWPe2QEQ28JeSJaSThYumWHboFBueRiL7O53hjYMN8MbzqdzP
         UFCxYnE1tJujVrv6eQ2ed8NoKOSrfNaWnPiDY66UQ32bXKDlbgoJ+wii8b1kY1uAyG+A
         xLcg==
X-Gm-Message-State: AFqh2ko7BWLf0ZAtTnV0i3p54TYOnqnf5rFFr58K2KNd3kZwSY4xMxEs
        FqT4yTLyODHrzd2KYxQZRY32lu7tGimdlZWBiuo=
X-Google-Smtp-Source: AMrXdXsJA8fvDGIVrfTl2tjHx/Qk7OaAO2oWFVNv9oNTc8BSKqqRs+R8bG1pTnBzRCVh4txvOhplzgVTXao04AEENeQ=
X-Received: by 2002:a05:6102:330c:b0:3d3:e956:1303 with SMTP id
 v12-20020a056102330c00b003d3e9561303mr3675154vsc.71.1674531316278; Mon, 23
 Jan 2023 19:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com> <20221218232217.1713283-9-evanhensbergen@icloud.com>
In-Reply-To: <20221218232217.1713283-9-evanhensbergen@icloud.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Jan 2023 05:35:04 +0200
Message-ID: <CAOQ4uxg6xVfow48j-yFBZ45-dwD=Kfm_aiT6ReQPhrTgaxzb5g@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] Add new mount modes
To:     Eric Van Hensbergen <evanhensbergen@icloud.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 19, 2022 at 2:22 AM Eric Van Hensbergen
<evanhensbergen@icloud.com> wrote:
>
> Add some additional mount modes for cache management including
> specifying directio as a mount option and an option for ignore
> qid.version for determining whether or not a file is cacheable.
>
> Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>


Eric,

A comment related to the entire series.

It is quite odd to see patches titled "Add new mount modes"
on fsdevel and possibly in git log later.

Would you mind adding 9p: prefix to your 9p patches
and the vast majority of filesystem patches do?

Thanks,
Amir.
