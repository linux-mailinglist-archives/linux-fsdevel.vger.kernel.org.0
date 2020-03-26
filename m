Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CDC193B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 10:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZJUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 05:20:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55893 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgCZJUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:20:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id z5so5619817wml.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sXBFML/XtT6BYO56nE3TPrG7uhRt0PlSkFwg9A2qfpY=;
        b=qBpEFa5/sTpKR6R5g5UKugHqQs/ZGAGUcwV3uAV+bBwWz9aisT/mS/91QKppl6qlHI
         wUxWLcheQawaqIBBvrnEZMGVnGJlZAQMJxokyUDZvZwpDmDJXHJdDUir3R+EmELVxmf7
         hPY6748hDdBY8k3DpbG4KaDS98MPJ2S/JF9mxA4hVNBjWXkJUJ9rgoY5cy2tSDAZ+L5I
         TPHT3HSVl+x9laU2YuIPyjuCz0a97Lol88bhn0GbbFWW+RqeMtJJruiA0A2/H8X9JDnj
         WQeFmeB0uen9l81xpUY3XHNDRLDIBkgd99dGov+GKbZeHsvYD+6VkUv9lBslQri8G4hP
         39Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sXBFML/XtT6BYO56nE3TPrG7uhRt0PlSkFwg9A2qfpY=;
        b=YJ6VH/7K15dePjkx3I0gLbA+fPsUD9/g5jAk+Es2hd5tCNzs1GHFuwu1GHFp9C0Z/r
         MKxXU5MayX87qN3H//UfcBVwNuRm4ohbsKvwyAZyxEi+r9NpBJemurEu0Qb/PARuP5Kx
         FVeicoOn/A1/HktpLT4FjTdyltk7spqKQKxwDKem83TayrJDoMjlsLhEWSTMaTwLxBWN
         LUOTe28FQgsBoI6K1yJAyzP6f+le0l4N9EZPDtZTeyhO9++2rdyuCadkCDHeC7m6IoiX
         lUr6kZffrDSUaYIMqOd4OQjdarygifrIDNl9SLvtuGfWYpS7iFfS765M4TnYMH5Rsq85
         s07w==
X-Gm-Message-State: ANhLgQ1O2sQgQhUcINSOZYMhSkSHXDzlATkhtcJtzUZzABdya0hEHjXm
        MnP47+yKfVxJUy93RM//QO/YyA==
X-Google-Smtp-Source: ADFU+vtDZud1W4kzZ6jnhCsyUbGIQfqAQUGlzX3Popp1e0ISYouK+WRstcHs6k91y8DM6H5j57fDrg==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr2230902wmy.66.1585214407926;
        Thu, 26 Mar 2020 02:20:07 -0700 (PDT)
Received: from linux-3.fritz.box (p200300D99702F2008AC61C9D9152AF6F.dip0.t-ipconnect.de. [2003:d9:9702:f200:8ac6:1c9d:9152:af6f])
        by smtp.googlemail.com with ESMTPSA id 127sm2744535wmd.38.2020.03.26.02.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 02:20:07 -0700 (PDT)
Subject: Re: xas_prev() on an idr tree? idr_get_prev()?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        linux-fsdevel@vger.kernel.org, 1vier1@web.de
References: <09bbe629-0621-c51b-111b-6168adef9731@colorfullife.com>
 <20190318181811.GQ19508@bombadil.infradead.org>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <a965fb16-8d9f-32b1-704d-8b94968cd65d@colorfullife.com>
Date:   Thu, 26 Mar 2020 10:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20190318181811.GQ19508@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,

On 3/18/19 7:18 PM, Matthew Wilcox wrote:
> On Mon, Mar 18, 2019 at 06:36:25PM +0100, Manfred Spraul wrote:
>> the ipc code needs to find the highest index allocated in an idr tree.
>> It is part of the user space API: The return value of semctl(), msgctl() for
>> ..._INFO contains that number.
>>
>> Right now, the number is updated by calling idr_find(--idx), until this
>> succeeds.
>> (ipc_rmid() in ipc/util.c).
>>
>> Is there a a standard function already?
>>
>> Should I create a patch that adds idr_get_prev() to the idr API?
> Oof, please don't add to the IDR API.  I've actually got a tree with all
> existing users of the IDR and radix tree APIs converted to the XArray.
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-conv
> (currently rebasing it on -rc1, checking over each patch for bugs before
> sending them off to the maintainers).

Any update?

I would have some time, and the (idx--) loop is on my list. With 
IPCMNI_EXTEND_SHIFT, we can loop over 2^24 entries...

- Should I review ipc xarray code and send it to Andrew for merging?

- Should I try to create a "xa_find_last(xa, &index, XA_PRESENT)" function?

The alternative would be a binary search with find next.
> Unfortunately, I didn't try to make ipc_rmid any smarter than it already is.
> That is, it currently looks like:
>
> @@ -433,7 +425,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>   {
>          int idx = ipcid_to_idx(ipcp->id);
>   
> -       idr_remove(&ids->ipcs_idr, idx);
> +       xa_erase(&ids->ipcs, idx);
>          ipc_kht_remove(ids, ipcp);
>          ids->in_use--;
>          ipcp->deleted = true;
> @@ -443,7 +435,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>                          idx--;
>                          if (idx == -1)
>                                  break;
> -               } while (!idr_find(&ids->ipcs_idr, idx));
> +               } while (!xa_load(&ids->ipcs, idx));
>                  ids->max_idx = idx;
>          }
>   }
>
> One of the things we need is an xa_for_each_rev() macro.  I think it
> should look like this:
>
> #define xa_for_each_rev(xa, index, entry)				\
> 	for (entry = xa_find_last(xa, &index, XA_PRESENT);		\
> 	     entry;							\
> 	     entry = xa_find_before(xa, &index, XA_PRESENT))
>
> I was going to work on that at some point in the next month or so,
> but if you want to take it on, I'd be awfully grateful!
>
> I don't know if we need an xas_find_last() / xas_find_prev() function.
> Without any user that I think would benefit from it, I'd be tempted to
> just do the xa_ versions.


