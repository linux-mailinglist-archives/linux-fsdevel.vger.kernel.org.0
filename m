Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93739A999
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFCR4z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 3 Jun 2021 13:56:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51772 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCR4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:56:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 19A9F1F43470
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, dlatypov@google.com,
        kernel@collabora.com, linux-fsdevel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2] unicode: Implement UTF-8 tests as a KUnit test
Organization: Collabora
References: <20210602123234.3009423-1-ricardo.canuelo@collabora.com>
Date:   Thu, 03 Jun 2021 13:55:05 -0400
In-Reply-To: <20210602123234.3009423-1-ricardo.canuelo@collabora.com>
        ("Ricardo =?utf-8?Q?Ca=C3=B1uelo=22's?= message of "Wed, 2 Jun 2021
 14:32:34 +0200")
Message-ID: <87fsxyj0jq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ricardo Cañuelo <ricardo.canuelo@collabora.com> writes:

> This translates the existing UTF-8 unit test module into a
> KUnit-compliant test suite. No functionality has been added or removed.
>
> Some names changed to make the file name, the Kconfig option and test
> suite name less specific, since this source file might hold more UTF-8
> tests in the future.
>
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> [Fix checkpatch's complaint. Fix module build.
>  Add KUNIT_ALL_TESTS to kconfig]
> Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> ---
> Thanks for the review, Daniel.

Thanks for picking this up again Ricardo.

Acked-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Ted, once ready, can you pick this up directly through your tree?

-- 
Gabriel Krisman Bertazi
