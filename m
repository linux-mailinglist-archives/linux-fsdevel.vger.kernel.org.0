Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1966E6E976C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjDTOnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjDTOne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:43:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D940EE;
        Thu, 20 Apr 2023 07:43:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a66911f5faso10508715ad.0;
        Thu, 20 Apr 2023 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682001802; x=1684593802;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=da4Vpw9yIgdkrWpPKCWhoT5kkyCNSRmtF4QY0pbAdc8=;
        b=X/u3bCgxYxbK4KjrPNgWqProfcLLOgrbgZHZSz09D3NZNc5UFZ/E8gG1Ae1H2xopFh
         r1gywDsOrIHgcEkxylMFzKzTnZlz+wIBbJwvGonrtxaZzVDtpXsKsog53euDG/MCJX4s
         caviq4Z1cwCZ3chPDad3cuO9+Wi+TW/PARKgc5bMo/ytPQCjFY4Cy3hkJJcrsHHZkeEq
         UFgemr//fDEnSvkryX5E0YOTP3xMAanr4x044X0WZ3nWzURD4UYsPeqtXdyzlLqb7NIf
         yFtjoXJH5MCoRWgnEBNlLTVud9i81DcmVaMTj9+s1QBqKIb+cMUK/pwF744q8XNqFu16
         RswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682001802; x=1684593802;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=da4Vpw9yIgdkrWpPKCWhoT5kkyCNSRmtF4QY0pbAdc8=;
        b=jP3qkIRTaX2lhw9emX+5mvyFEgAcvGvR1FiAPtZRgPl8Aro+Ng6sRjdfZlAKosvrA8
         +eUdr0Eq91k63szqjE9UVxaimO5tYbhaVKUijK4tdZUU9sWO4BhH/YBTaTGlPJ5QxMdB
         OI+ghKDSWJA4/4v1p4I91WCXQVp/hTqS98PH4WSch+RitWHnmV53G/qzAuUOC9XDVwo3
         1zfeoRgxE8ijK7g6H/CDdKSIxzUE5HFSmj5YWS96402P8JoyZ0hQVP1w+rB4uQn/wlaK
         CqsB0ltgmZ6c60XnLRDnd65ImOimK6SUhJhCHt2t8+W/TrfAPUb+vhqmNRtWH0LISNdD
         ro9Q==
X-Gm-Message-State: AAQBX9e4wzb2bSyAZaLRzWjxeVNpjlkhFnh3tN/tFpziWKddhAJmIhwZ
        RZywogI5paVhWhfgiW+FeEk=
X-Google-Smtp-Source: AKy350YohS9pVm7vdCF4ViO+giL6b6ueQHANA9z5bf0YMNWY2JrUwwZSZPfnNybusQpwMDuXOLdT1A==
X-Received: by 2002:a17:902:64c2:b0:1a6:9671:253e with SMTP id y2-20020a17090264c200b001a69671253emr1703970pli.47.1682001802249;
        Thu, 20 Apr 2023 07:43:22 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027d8700b001a653a32173sm1276530plm.29.2023.04.20.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:43:21 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:12:56 +0530
Message-Id: <87jzy6iphr.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync implementation
In-Reply-To: <ZD4k3Sp7wDQu4wkU@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Apr 17, 2023 at 06:45:50PM +0200, Jan Kara wrote:
>> Hum, I think the difference sync vs fsync is too subtle and non-obvious.
>
> Agreed.
>
>> I can see sensible pairs like:
>>
>> 	__generic_buffers_fsync() - "__" indicates you should know what you
>> 				are doing when calling this
>> 	generic_buffers_fsync()
>>
>> or
>>
>> 	generic_buffers_fsync()
>> 	generic_file_fsync() - difficult at this point as there's name
>> 			       clash
>>
>> or
>>
>> 	generic_buffers_fsync_noflush()
>> 	generic_buffers_fsync() - obvious what the default "safe" choice
>> 				  is.
>>
>> or something like that.
>
> I'd prefer the last option as the most explicit one.

Yes. I was going to use this one as this is more explicit.

Thanks Jan & Christoph,
I will spin a new revision soon with the suggested changes.

-ritesh
