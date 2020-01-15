Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48013C4F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAOOHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:07:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOOHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:07:19 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MBV2f-1iwQh13Mat-00D2xA; Wed, 15 Jan 2020 15:07:09 +0100
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        YunQiang Su <ysu@wavecomp.com>
References: <20191122150830.15855-1-laurent@vivier.eu>
 <b39e59a6-82f2-2122-5b22-4d8a77eda275@vivier.eu>
 <2a464b33-0b1d-ff35-5aab-77019a072593@vivier.eu>
 <20200115135527.GG8904@ZenIV.linux.org.uk>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [RFC v2] binfmt_misc: pass binfmt_misc flags to the interpreter
Message-ID: <20e6c345-b984-7b28-4d3f-c8f3799b8579@vivier.eu>
Date:   Wed, 15 Jan 2020 15:07:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115135527.GG8904@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nTwzQVh2u4oVadeeiv+dIe1lMrHXNviOKXiJwUq0IR1CGR5YW7i
 lWt3QbVabpPspqHHsb01rMgUnL+DDd8q3xcSKTZHRg+wfeN33hHFfvMIxIrzAtmM6EqKJXI
 OC/R/nt1EwBexq3Vfn7Vh+VrpZxF94jqcKF+W+Cs71Gmvs1EGlLeITLVHVbaVEPSdL0Ucjs
 ttL5GiwLcorc9ZFgp5S/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1gVj2CRluU=:+oUeag9k4GsJtut/wbXOtF
 NEXjja5oN1/HXNc6axFNrVfUwocqMGOJnp33bSptcUq+z1HbwSxtTnUKu0NrdtQ5qM87Lb1cK
 CbY6J8Xj1LDA2ykkEUC6IQCydoZ/ythKi0O/+h7C2JNEbPYVKER3z3OQaVDnIcR3LmTKFaLvU
 BUvv6k+jlsUHh+iSvpx0r3h2fnn3IRhWyp+z8IN1+4WmSgjX+0ma+IGACjrNbCwh/RO416z1D
 JDnKZRLCa3qxgjAp51HhTMNqx+Lkx6O2o+q3dHkHlAtLX+B5DZBXD83pQZNFxSkJTLvG8W0FF
 f2vedyA0VkrVZkBmJkWajasp/d+T76CDkKM9vS0xKlD7WgNGUjADS+OjnOvhTXNk0IF3l2FCb
 wRqCUY99LfX3flle3T318iAONTBbLD1PVUx1W5Ac2yxty4ICr2z66DhOf2cW3OPHvxLcxOUPF
 crlj9YWcf7AgU8Z+8S9eVPn5bSeMNpQ0ylZzjdAAAx6RABI/k2YKp7FeyZP4mFx6rNLjV564u
 nZcf34KWahCDcQqjRHFGtAvVkGX81k4Fiq5OzgQxyqB3Vey4RgTlo5VxzRx6qGqt+UPFrHKDc
 tf66QzjuL/INKVMvG2VMwUQx3VW87014ky1aM2Op7EMtddpU5WZ2jp++sis3AB2Ey1ASqCWeq
 54cdZOxza40DaHG2wLGM9e9xP+DB4/c/GLKRgqy6sv1uUrh5jzJ7g2r/gWUE5LKOinl1qe7j0
 YHU3+Pwc4i9H5rlCZQUBkxIXtFRXgKFqOBJ3TxfvrwrPgYllmzmOcWRiEIrsRX/4pN8nTli/E
 04IRpm6u0bkcHf9L3hS6nhWuBja/Ydy75PxVG4lE3xXvrggbjZ6jxJlc3xRvp0VDvj6q9eALp
 gLUttve8FxwjWPR0E0ykZF44ocjWdzMsotlSPMsMc=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 15/01/2020 à 14:55, Al Viro a écrit :
> On Wed, Jan 15, 2020 at 01:19:16PM +0100, Laurent Vivier wrote:
>> Le 07/01/2020 à 15:50, Laurent Vivier a écrit :
>>> Hi,
>>>
>>> this change is simple, easy to read and understand but it is really
>>> needed by user space application interpreter to know the status of the
>>> system configuration.
>>>
>>> Could we have a comment saying if there is a problem or if it is good to
>>> be merged?
>>
>> Anyone?
> 
> 	FWIW, one thing that looks worrying here is that these bits become
> userland ABI after this patch - specific values passed in that thing
> can't be changed.  And no a single mention of that in fs/binfmt_misc.c,
> leaving a nasty trap.  As far as one can tell, their values are fair game
> for reordering, etc. - not even visible outside of fs/binfmt_misc.c;
> purely internal constants.  And the effect of such modifications after
> your patch will not be "everything breaks, patch gets caught by somebody's
> tests" - it will be a quiet breakage for some users.
> 
>>>>  #define MISC_FMT_OPEN_BINARY (1 << 30)
>>>>  #define MISC_FMT_CREDENTIALS (1 << 29)
>>>>  #define MISC_FMT_OPEN_FILE (1 << 28)
>>>> +#define MISC_FMT_FLAGS_MASK (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY | \
>>>> +			     MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)
> 
> IOW, you are making those parts of userland ABI cast in stone forever.
> Whether this bit assignment does make sense or not, such things really
> should not be hidden.
> 

Thank you for your answer.

So I think the patch from YunQiang Su is a better approach than mine,
much cleaner, see:

  binfmt_misc: pass info about P flag by AT_FLAGS
  https://patchwork.kernel.org/patch/10902935/

It does the same thing as my patch but uses a dedicated value for AT_FLAGS.

Perhaps YunQiang can send a new version (without the kdebug() part)?

Thanks,
Laurent
