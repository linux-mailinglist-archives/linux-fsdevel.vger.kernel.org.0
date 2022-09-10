Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85DA5B4612
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIJLeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIJLeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:34:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5AD53D05
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 04:34:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc7so9942268ejb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8Ag6mHz6RaJKAvIf3yWG8/NFxf6UdfL+MIDBEsLCyN8=;
        b=rt56lu4zDxtfFC0gCwopFBFWhVClMEv05ZLa6FVTJvWQfkY2PRelXahCVRkTH0W0EE
         SDi7Jg1T1Uk7Cgx8nOrb1llp4a5ljwV0hdWJLnKvHp44g8AGFKUUuXIYEu47fVHTnc+/
         8wGHkEV4bRaaeVojMOyW1sd84KJqpHyhoHmwKscMTML1EIFROO1ffCslzJIrMkPlYesA
         CBTvyvCmvmcJsItPrNfbGgD6LX3xXNlU+Uvr8Wo01rpF/CTHcxytcMd7P56VsFix0FeR
         nYU0jAzsSdPZvhNnm7dXkuhgwaXZBEfS/U1FJvc3Zvz9IP4l/XZZ4aGZLlBa7gaLGUT8
         q2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8Ag6mHz6RaJKAvIf3yWG8/NFxf6UdfL+MIDBEsLCyN8=;
        b=hJci7lsc1FvpRadErnrnrI185qo3VD3hmgBlBZFajnqycwbZeOujM5/y5iQ6kAvOyQ
         mP8eKHvlXNpKfGi5soeJyz5v88n6pWXJkfoaKVVDc8rrroaidxPbFCrXiaWDnX5W1nPr
         eL1Qni9+09DwTsZcyCbLmKOl4vUiBh22a/YeNUfKjbA4k9mzIPWR/Bkz0gSlPy78n0HH
         ppjIoIYC79K+siDPPUBW+TAmklW7Lz8M+OMjthLG+v42gwfW1ykR00nH73kK+p7D/abX
         mzpXZz4/rB9UIBNqfHaveenaaDA0R5pAfHn+fr2mDpQyu26FZEi9tBmqfIyrevyKc+p1
         9tUg==
X-Gm-Message-State: ACgBeo3bYUu7kh0ZnTMQPME0bjDaGcgl1zVE133xPzF4htpU1gokQY9h
        wbIblLaJBZQ9ksy7XCPu44iVWA==
X-Google-Smtp-Source: AA6agR6l/1o9KPVR6GtRSUN/6LhKnQUVR80O3xKSuOcDWQt5wKNsZnh3qcOtdZWGGeWimCE3wtzgXg==
X-Received: by 2002:a17:906:9750:b0:77b:6f08:986f with SMTP id o16-20020a170906975000b0077b6f08986fmr1210041ejy.416.1662809644338;
        Sat, 10 Sep 2022 04:34:04 -0700 (PDT)
Received: from [10.41.110.194] ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b0044e8d0682b2sm2014194edu.71.2022.09.10.04.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 04:34:03 -0700 (PDT)
Message-ID: <bcabe527-7940-8658-1728-28d64bd3cf80@kernel.dk>
Date:   Sat, 10 Sep 2022 05:34:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/22 12:50 AM, Christoph Hellwig wrote:
> @@ -2390,8 +2392,13 @@ static int filemap_read_folio(struct file *file, filler_t filler,
>  	 * fails.
>  	 */
>  	folio_clear_error(folio);
> +
>  	/* Start the actual read. The read will unlock the page. */
> +	if (unlikely(workingset))
> +		psi_memstall_enter(&pflags);
>  	error = filler(file, folio);
> +	if (unlikely(workingset))
> +		psi_memstall_leave(&pflags);
>  	if (error)
>  		return error;

I think this would read better as:

  	/* Start the actual read. The read will unlock the page. */
	if (unlikely(workingset)) {
		psi_memstall_enter(&pflags);
		error = filler(file, folio);
		psi_memstall_leave(&pflags);
	} else {
		error = filler(file, folio);
	}
  	if (error)
  		return error;

-- 
Jens Axboe
