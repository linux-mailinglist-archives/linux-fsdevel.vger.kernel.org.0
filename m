Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B150613398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 11:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJaK2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJaK2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:28:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178EDFD1;
        Mon, 31 Oct 2022 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BJwLOmLD8mORoDRX0DLkp+ifKRPcytGG+quIHFk/eeg=; b=d5hQmn1G6fFW9tEkhDd1r9oIyo
        HHq37m3+bMHObABPRn2mbJqtWjLIlLkULlu7/G7/8XPX+SQaFzlPjNwOk7CQY0s0oKntWXQiI8S6+
        mKGEgyQWk7/KmjBX6fgCxiqvu9clNVtRYPOzuJ6BiqjoDjT7Ro9ybWR/7pULj3u+tSPI2RUp2epyI
        s15IZQnifoEY0p14+hWUZzcnGh/q/KNvpWZVQX9QtHMOuGEOAJOpfNcDsUbH30I9eAVwRwPY4MvQy
        ef/TKMLmozncYEuorFuGczjY123W8zK+NHkpYLLhMjRoV2UoveEoFkpkSt7RjFP8SIsZwhM6/Ici5
        C6Ltkd7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opS1N-003awy-W1; Mon, 31 Oct 2022 10:27:58 +0000
Date:   Mon, 31 Oct 2022 10:27:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     zhaogongyi <zhaogongyi@huawei.com>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH -next 2/2] selftests/mincore: Optimize
 TEST(check_file_mmap) accoring to filemap read around
Message-ID: <Y1+jLVnlW4pR2Lu0@casper.infradead.org>
References: <cc7e3b29ef0445188e871f94f6d9cbd0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7e3b29ef0445188e871f94f6d9cbd0@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 07:22:11AM +0000, zhaogongyi wrote:
> Hi!
> 
> +to linux-fsdevel@vger.kernel.org
> +cc willy@infradead.org
> 
> Regards,
> Gongyi

what?
