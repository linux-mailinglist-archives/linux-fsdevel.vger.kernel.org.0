Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A448144856
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 00:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAUXcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 18:32:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:40826 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:32:55 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iu30v-00035F-O3; Wed, 22 Jan 2020 00:32:53 +0100
Received: from [178.197.248.28] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iu30v-000KVM-HO; Wed, 22 Jan 2020 00:32:53 +0100
Subject: Re: [PATCH][bpf] don't bother with getname/kern_path - use
 user_path_at
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200120232858.GF8904@ZenIV.linux.org.uk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <16c6b94e-81cb-0b93-d1a5-db72768b0048@iogearbox.net>
Date:   Wed, 22 Jan 2020 00:32:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200120232858.GF8904@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25702/Tue Jan 21 12:39:19 2020)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/20 12:28 AM, Al Viro wrote:
> 	kernel/bpf/inode.c misuses kern_path...() - it's much simpler
> (and more efficient, on top of that) to use user_path...() counterparts
> rather than bothering with doing getname() manually.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good, applied, thanks!
