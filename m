Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B94FE9DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiDLVGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 17:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiDLVGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918115470D;
        Tue, 12 Apr 2022 13:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5352761C54;
        Tue, 12 Apr 2022 20:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A248C385A1;
        Tue, 12 Apr 2022 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649796069;
        bh=YBvi7BvRSFhTBMnNDQglW7gASkP9HGdcSPqceH085lI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aeILG2DvCifC4VQbXqYyZL6IYHEItaTTEt7soKXalXltcIDglD7Pna4yAKKMsn/qG
         lKQ8QtJofwT1FT1yzZo8Mi9p+ZqJxF5eoa1ZHH3WyZe0DYWjM71Bi+BbiVwJa8bDmW
         jgI2XdYfWONemapxaloIcZy26WSTHGHRN+kxBy4o=
Date:   Tue, 12 Apr 2022 13:41:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Message-Id: <20220412134108.b95b6c92183b3d9c1dd11b47@linux-foundation.org>
In-Reply-To: <20220412202942.386981-1-axelrasmussen@google.com>
References: <20220412202942.386981-1-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 Apr 2022 13:29:41 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> To achieve this, add a /dev/userfaultfd misc device.

An update to $(grep -rl userfault Documentation/) seems appropriate?
