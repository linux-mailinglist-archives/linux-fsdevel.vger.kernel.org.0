Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBBF2B439C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 13:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgKPMXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 07:23:37 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:49655 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKPMXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:23:36 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0AGCNVIG030502;
        Mon, 16 Nov 2020 21:23:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Mon, 16 Nov 2020 21:23:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0AGCNVNa030496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Nov 2020 21:23:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Garbage data while reading via usermode driver?
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0c98ab7f-8483-bb54-7b8f-3d69ed45f1ff@i-love.sakura.ne.jp>
Message-ID: <8e18b2d9-a202-9287-a17a-19662f0d34ae@i-love.sakura.ne.jp>
Date:   Mon, 16 Nov 2020 21:23:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <0c98ab7f-8483-bb54-7b8f-3d69ed45f1ff@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/16 20:11, Tetsuo Handa wrote:
> Why there is garbage data if I use "#!" ?

I overlooked that execution of "umd_test" containing "#!/bin/cat some_file" results in
execution of "/bin/cat some_file umd_test". Nothing is strange. Sorry for the noise.
