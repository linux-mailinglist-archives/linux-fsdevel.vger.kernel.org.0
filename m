Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA83A740B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 21:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICTwH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 3 Sep 2019 15:52:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38940 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfICTwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:52:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6D44028B13F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: Move static keyword to the front of declarations
Organization: Collabora
References: <20190830131349.14074-1-kw@linux.com>
Date:   Tue, 03 Sep 2019 15:52:01 -0400
In-Reply-To: <20190830131349.14074-1-kw@linux.com> (Krzysztof Wilczynski's
        message of "Fri, 30 Aug 2019 15:13:49 +0200")
Message-ID: <85blw1gntq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Krzysztof Wilczynski <kw@linux.com> writes:

> Move the static keyword to the front of declarations of nfdi_test_data
> and nfdicf_test_data, and resolve the following compiler warnings that
> can be seen when building with warnings enabled (W=1):
>
> fs/unicode/utf8-selftest.c:38:1: warning:
>   ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>
> fs/unicode/utf8-selftest.c:92:1: warning:
>   ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>

Applied.

Thanks,

-- 
Gabriel Krisman Bertazi
