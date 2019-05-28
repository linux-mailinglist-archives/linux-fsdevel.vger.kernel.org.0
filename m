Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAF2CDE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfE1Rrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 13:47:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Rrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 13:47:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7195E263975
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: replace strncpy() by strscpy()
Organization: Collabora
References: <20190527174733.GA29547@embeddedor>
Date:   Tue, 28 May 2019 13:47:49 -0400
In-Reply-To: <20190527174733.GA29547@embeddedor> (Gustavo A. R. Silva's
        message of "Mon, 27 May 2019 12:47:33 -0500")
Message-ID: <8536kympx6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> The strncpy() function is being deprecated. Replace it by the safer
> strscpy() and fix the following Coverity warning:
>
> "Calling strncpy with a maximum size argument of 12 bytes on destination
> array version_string of size 12 bytes might leave the destination string
> unterminated."
>
> Notice that, unlike strncpy(), strscpy() always null-terminates the
> destination string.
>

Thanks, I'll get this queued up.

-- 
Gabriel Krisman Bertazi
