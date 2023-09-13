Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804A79EF22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjIMQoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjIMQoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:44:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D24C22
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:41:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C40C433C8;
        Wed, 13 Sep 2023 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694623282;
        bh=ePRmbVLmq3TIPGaB0RL19wxutLgZWDbOkXmOFx1sX4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/vOzUjZMCsJtUjATPDbcUL4bwbwVenApEscHllgxC4OVH+kRHGlMpQ/o0Za+3/zI
         IjWyUulRflaB2pVouW3/XbFczKyfFsTgEQVxo8pPQmW4qxvB+fdfvJ+wGecL5CvJQu
         vbNDh5dprI6i8F+5HxAeoDhWvIIqgHUp5vQT/IhKw7qAdbWYIEmcRi9zpm427jzRem
         xlMobwY9/OdjinDNv8IHRbICVKMldA7t6C9F4Ey+y8Eu0ACAwoaAiynBRsmeEvRwOc
         x36guldNIhgFVa/KT0jd8H0u4EggNNSAPFNluUZcihFoVfolHMwqgEHJT/x+3ts4G9
         YDYlYQb1LhrGg==
Date:   Wed, 13 Sep 2023 18:41:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
Message-ID: <20230913-testen-zeitbegrenzung-a4bbdb3294b1@brauner>
References: <20230912185408.3343163-1-amir73il@gmail.com>
 <20230913-sticken-warnzeichen-099bceebc54d@brauner>
 <CAOQ4uxiDpMkR-45m9X6AinK50oK5fMBsvmQfHW94U40ngJWV=Q@mail.gmail.com>
 <CAOQ4uxhG5=Oszi8CqU0gaG3t2nYpT3Rteg3xjvpJ4CzkUUL7=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhG5=Oszi8CqU0gaG3t2nYpT3Rteg3xjvpJ4CzkUUL7=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> and add the entry:
> FILESYSTEM [BACKING FILE]

Yeah, sorry. I didn't look at the prefix.
FILESYSTEMS is obviously fine!
