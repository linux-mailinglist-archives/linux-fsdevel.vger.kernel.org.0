Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65943284D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfEWRWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 13:22:44 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32831 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbfEWRWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 13:22:44 -0400
Received: by mail-wr1-f43.google.com with SMTP id d9so7174881wrx.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=InxZ5iLACNFG7Vx1pJFG6j1VGK3C8LKW3Pv0n2HdX+A=;
        b=sjyydNsJzBhRt7U6ln+3IbD5L5Ezv5HWlrW9gK6JoZHadmqbtaTf6UIYof4YJQNjkI
         knfn9lOG4i3LpC8Rg8Ucmml6uxYOC/vHyqiB7yFhOxYG5UhKLhHi/uc1IO9Kx8Qgm++K
         6yX5FY9El4TWPjlZjpf8Tv4GX//JNe0nFd09+cGSWHiG3z3t9UNn3ubDWj60uetL67Hh
         U/q8Y1AzeH7KgRfimm21QLJmJhbSPuxq2F/GI0Xd9CHZUWW5IXB20yX9FKRSbTWMX1IU
         H4Yk2feL3OV3vjN4KRm2qwt+bIvua+6CmJPRLoarc8mAtE/Ay/55PIH42X9ZpkS4K8Wi
         daZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=InxZ5iLACNFG7Vx1pJFG6j1VGK3C8LKW3Pv0n2HdX+A=;
        b=iLNKhF12pYdExrIPHBHCSeeM9PnBm/HQ5rlb1y0HK07lFEuxeMYinDDB+OOWi/uCag
         hK/BlQWl2ozDQm4bzH6/w450+E3KPTNqnT5J7KCyAeEhXO6L3YiOu3wNbu5OX2mSaEDl
         oS97PdgZTzizwoBTYEh09I6ecCkPz3tvRzsWBgLK//hI+0BawiyauxoAfpVtqQxMSjW3
         BcKA2dxRSc3Qt/UFR4AiUJg6kUOPyOM5KHG98oEvs+bS4o2VSPledPxT0MQT0YwPS9aw
         nXdiaYe/nwDa1a2lf33TlHxWZQ1z5STRC1R/dPJAQF4pru5QzReZ1/n12FJCS57f4F8K
         Onmg==
X-Gm-Message-State: APjAAAW7wWuw8wk8LT1TnZESKWmNNKYML8pumUR+8wYiOfKIjy2UwXp1
        Z62MLek0XLRNjUrrYRY64n96Kg==
X-Google-Smtp-Source: APXvYqzF8+G3wET+S+exvjqW8Kxk9v9JrFg/Ri5mOyFh+MPsPVxxp7tvqZ62rRx3VVW1PeiwSCK1fQ==
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr2229827wrr.149.1558632161613;
        Thu, 23 May 2019 10:22:41 -0700 (PDT)
Received: from [192.168.0.102] (84-33-65-143.dyn.eolo.it. [84.33.65.143])
        by smtp.gmail.com with ESMTPSA id z4sm30491894wru.69.2019.05.23.10.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:22:40 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <2A58C239-EF3F-422B-8D87-E7A3B500C57C@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D45781B4-9ACB-4EB0-B468-DF882BDE48A5";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Thu, 23 May 2019 19:22:38 +0200
In-Reply-To: <6FE0A98F-1E3D-4EF6-8B38-2C85741924A4@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <A0DFE635-EFEC-4670-AD70-5D813E170BEE@linaro.org>
 <5B6570A2-541A-4CF8-98E0-979EA6E3717D@linaro.org>
 <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
 <FC24E25F-4578-454D-AE2B-8D8D352478D8@linaro.org>
 <0e3fdf31-70d9-26eb-7b42-2795d4b03722@csail.mit.edu>
 <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
 <686D6469-9DE7-4738-B92A-002144C3E63E@linaro.org>
 <01d55216-5718-767a-e1e6-aadc67b632f4@csail.mit.edu>
 <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
 <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
 <6FE0A98F-1E3D-4EF6-8B38-2C85741924A4@linaro.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D45781B4-9ACB-4EB0-B468-DF882BDE48A5
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_3B66D298-FEA1-4A37-ABBE-8A493C140EF6"


--Apple-Mail=_3B66D298-FEA1-4A37-ABBE-8A493C140EF6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 23 mag 2019, alle ore 11:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 23 mag 2019, alle ore 04:30, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>=20
>> On 5/22/19 3:54 AM, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 22 mag 2019, alle ore 12:01, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>=20
>>>> On 5/22/19 2:09 AM, Paolo Valente wrote:
>>>>>=20
>>>>> First, thank you very much for testing my patches, and, above all, =
for
>>>>> sharing those huge traces!
>>>>>=20
>>>>> According to the your traces, the residual 20% lower throughput =
that you
>>>>> record is due to the fact that the BFQ injection mechanism takes a =
few
>>>>> hundredths of seconds to stabilize, at the beginning of the =
workload.
>>>>> During that setup time, the throughput is equal to the dreadful =
~60-90 KB/s
>>>>> that you see without this new patch.  After that time, there
>>>>> seems to be no loss according to the trace.
>>>>>=20
>>>>> The problem is that a loss lasting only a few hundredths of =
seconds is
>>>>> however not negligible for a write workload that lasts only 3-4
>>>>> seconds.  Could you please try writing a larger file?
>>>>>=20
>>>>=20
>>>> I tried running dd for longer (about 100 seconds), but still saw =
around
>>>> 1.4 MB/s throughput with BFQ, and between 1.5 MB/s - 1.6 MB/s with
>>>> mq-deadline and noop.
>>>=20
>>> Ok, then now the cause is the periodic reset of the mechanism.
>>>=20
>>> It would be super easy to fill this gap, by just gearing the =
mechanism
>>> toward a very aggressive injection.  The problem is maintaining
>>> control.  As you can imagine from the performance gap between CFQ =
(or
>>> BFQ with malfunctioning injection) and BFQ with this fix, it is very
>>> hard to succeed in maximizing the throughput while at the same time
>>> preserving control on per-group I/O.
>>>=20
>>=20
>> Ah, I see. Just to make sure that this fix doesn't overly optimize =
for
>> total throughput (because of the testcase we've been using) and end =
up
>> causing regressions in per-group I/O control, I ran a test with
>> multiple simultaneous dd instances, each writing to a different
>> portion of the filesystem (well separated, to induce seeks), and each
>> dd task bound to its own blkio cgroup. I saw similar results with and
>> without this patch, and the throughput was equally distributed among
>> all the dd tasks.
>>=20
>=20
> Thank you very much for pre-testing this change, this let me know in
> advance that I shouldn't find issues when I'll test regressions, at
> the end of this change phase.
>=20
>>> On the bright side, you might be interested in one of the benefits
>>> that BFQ gives in return for this ~10% loss of throughput, in a
>>> scenario that may be important for you (according to affiliation you
>>> report): from ~500% to ~1000% higher throughput when you have to =
serve
>>> the I/O of multiple VMs, and to guarantee at least no starvation to
>>> any VM [1].  The same holds with multiple clients or containers, and
>>> in general with any set of entities that may compete for storage.
>>>=20
>>> [1] =
https://www.linaro.org/blog/io-bandwidth-management-for-production-quality=
-services/
>>>=20
>>=20
>> Great article! :) Thank you for sharing it!
>=20
> Thanks! I mentioned it just to better put things into context.
>=20
>>=20
>>>> But I'm not too worried about that difference.
>>>>=20
>>>>> In addition, I wanted to ask you whether you measured BFQ =
throughput
>>>>> with traces disabled.  This may make a difference.
>>>>>=20
>>>>=20
>>>> The above result (1.4 MB/s) was obtained with traces disabled.
>>>>=20
>>>>> After trying writing a larger file, you can try with low_latency =
on.
>>>>> On my side, it causes results to become a little unstable across
>>>>> repetitions (which is expected).
>>>>>=20
>>>> With low_latency on, I get between 60 KB/s - 100 KB/s.
>>>>=20
>>>=20
>>> Gosh, full regression.  Fortunately, it is simply meaningless to use
>>> low_latency in a scenario where the goal is to guarantee per-group
>>> bandwidths.  Low-latency heuristics, to reach their (low-latency)
>>> goals, modify the I/O schedule compared to the best schedule for
>>> honoring group weights and boosting throughput.  So, as recommended =
in
>>> BFQ documentation, just switch low_latency off if you want to =
control
>>> I/O with groups.  It may still make sense to leave low_latency on
>>> in some specific case, which I don't want to bother you about.
>>>=20
>>=20
>> My main concern here is about Linux's I/O performance out-of-the-box,
>> i.e., with all default settings, which are:
>>=20
>> - cgroups and blkio enabled (systemd default)
>> - blkio non-root cgroups in use (this is the implicit systemd =
behavior
>> if docker is installed; i.e., it runs tasks under user.slice)
>> - I/O scheduler with blkio group sched support: bfq
>> - bfq default configuration: low_latency =3D 1
>>=20
>> If this yields a throughput that is 10x-30x slower than what is
>> achievable, I think we should either fix the code (if possible) or
>> change the defaults such that they don't lead to this performance
>> collapse (perhaps default low_latency to 0 if bfq group scheduling
>> is in use?)
>=20
> Yeah, I thought of this after sending my last email yesterday. Group
> scheduling and low-latency heuristics may simply happen to fight
> against each other in personal systems.  Let's proceed this way. I'll
> try first to make the BFQ low-latency mechanism clever enough to not
> hinder throughput when groups are in place.  If I make it, then we
> will get the best of the two worlds: group isolation and intra-group
> low latency; with no configuration change needed.  If I don't make it,
> I'll try to think of the best solution to cope with this non-trivial
> situation.
>=20
>=20
>>> However, I feel bad with such a low throughput :)  Would you be so
>>> kind to provide me with a trace?
>>>=20
>> Certainly! Short runs of dd resulted in a lot of variation in the
>> throughput (between 60 KB/s - 1 MB/s), so I increased dd's runtime
>> to get repeatable numbers (~70 KB/s). As a result, the trace file
>> (trace-bfq-boost-injection-low-latency-71KBps) is quite large, and
>> is available here:
>>=20
>> https://www.dropbox.com/s/svqfbv0idcg17pn/bfq-traces.tar.gz?dl=3D0
>>=20
>=20
> Thank you very much for your patience and professional help.
>=20
>> Also, I'm very happy to run additional tests or experiments to help
>> track down this issue. So, please don't hesitate to let me know if
>> you'd like me to try anything else or get you additional traces etc. =
:)
>>=20
>=20
> Here's to you!  :) I've attached a new small improvement that may
> reduce fluctuations (path to apply on top of the others, of course).
> Unfortunately, I don't expect this change to boost the throughput
> though.
>=20
> In contrast, I've thought of a solution that might be rather
> effective: making BFQ aware (heuristically) of trivial
> synchronizations between processes in different groups.  This will
> require a little more work and time.
>=20

Hi Srivatsa,
I'm back :)

First, there was a mistake in the last patch I sent you, namely in
0001-block-bfq-re-sample-req-service-times-when-possible.patch.
Please don't apply that patch at all.

I've attached a new series of patches instead.  The first patch in this
series is a fixed version of the faulty patch above (if I'm creating too
much confusion, I'll send you again all patches to apply on top of
mainline).

This series also implements the more effective idea I told you a few
hours ago.  In my system, the loss is now around only 10%, even with
low_latency on.

Looking forward to your results,
Paolo


--Apple-Mail=_3B66D298-FEA1-4A37-ABBE-8A493C140EF6
Content-Disposition: attachment;
	filename=patches-with-waker-detection.tgz
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="patches-with-waker-detection.tgz"
Content-Transfer-Encoding: base64

H4sIABvW5lwAA+1ae3ObSBLff6VP0fFWspIlZN5IcuzK45zb1CW5JE6ucrW3RQ0wWKwRSIDsuJJ8
9+uZAYEkJDvr2HVbR5fLSNDTzHT/pl+jGcncCU2lyyCbSJfknCaSRzPqZkEcHfz0Y0iWZcswgF9N
cZVVXVxzAkXTLcUwNFnWQFYs/PsJjB/0/p20SDOS4FRmJA7jHXzI5vs7nufrWF7/IjTbZX9ciCI5
YeyeS44/lxIqpWQ6Cyl+mkspTS4Cl0pZMGXjJzSSZnGaBk5IB1zq8h0oxtT1rfZXLNMq7K9amgGy
pmqy+RPI96GA/3P7v0jiKbgukU3X1TRH1ojhG8ZwRFVierLuKYrnqL7rOJo7GsLrOIJTOgPFAlke
8z9Q0YJtJmYMb5kO4V8kpFFG4TFX6eBCfH0SBhFJ4kGcnB23/0YyOoYPk0UfVA1ekyuUooxAkceG
PtZl6MkotX26cP5AJI7ht7dPPzz/FZQD/XfgcOwD4nEMS0DipznkgAQOSGCAhAKQ7fZpcBZRT4p9
X3KuvmOmkiS1xTsP2BYI4hS3izdw4SsMoScIORTwA5yGOyHRGfX6YEEQ4XzYLko7vW4fGTwaUva9
I3XbbS/wfZCksyADclAn3qm72w4ij36Goa97MtXQTEN/MHCI6sv+0PId6qAG2VZjs66X28bpbpH9
5AlIpqwZfQt6/KpogPcQ91ngwkUceEzp9mLmofHsIGKmscNgGmSdNEsWbsYf40MC+/jJ67eh1YJ9
JiDJIEuugugMxDDUwkA8PWAX5J5Lx1WJcART8tnOOoso5YbDgRkqsQ9x6AmW7mFban1r91rfgIYp
hcCHzgP2Xuk4maf5/HDgo0dQ3MWbtpcEFzSBoyNQuji4dbDP/uM0/0BHUAGUmFNI0sxmuLIZqOwo
hSwGPw7D+DIfdhkn52FMvNz0qbh9wC7bRByhkKz4dtjutQGVcLAPQrPgxmwCGe1DFGdwSYKMKc6P
EyDRFQP6guJMcy7UJL8dxvjyROhTLJcNpJ6dzPF9bz6+eoXqkqCtDlR5oLTby/1/nf9XK/6fRIiE
AEeglig9l7JJEJ1z/y+Jua/5/YKu8f8a0pr/l03Tavz/fRD3/z41ZN8bjjTH1H3FU2TfNKlHVZWa
qkt11fN1nxKf3rn/t8YGytS2+H913f+XgAQGyEcckNz/55vpTvy+snT8PWlJmyFguBEC5GUMSG8f
BKpufzAYmYZCDdN0fIfcNggYuqn20Ro9/mG0IwhMSGqnkzhBb8aUvjUOrA9HV0wj9GML6m0ZA5Xb
nJHfn/OY0gKk/HnhDveTebcNXzAkVAYGse3OcSC++gjev7OfvXzeQT70hCiGxYsE/bM79Ww/JGcp
PIL3J+/s1ycfnnbLqDSlGbFnNPLQCfd6h+irpVY1DMY2Bx1fvpg5G8eD0w5FlZz4P3DX2VEqw/MG
az55wRvGZza7XeXAR1w7sLf2xqOHHnSYzCt46HX3SkYmiQ2tm+IcQfvsxbt39unJyT/+Le7k2qvE
ttwENuZaqGYnPGfmxS9M1dArbqS4keMkFfqHXP9MCgvFImJhdM5TuNzkInSL6bFwVrwqnwmam8PV
sLS+iWg1TK2v6BW4OnEcgm1zKPCtuBSwG3SroBJIwKVF9JLPBeePiQdgiL8REHo3BUKrhOj6sJ2A
6OW8tYDo3RQQvT8PCMxgWkWewo05v8Z0hwJBNvG85QMBjFbghZTnRontBSnB3N1DmYV0FPtgp9za
HKeh7XRd/qdV87/wklylkkitBXMq5QZIt+R+jK7J/yxT38j/VFVu8r/7IJ7/WYaLSZ5jydSyFE9V
RkPNpUOFqDpVNcV1PHmkU00e3Xn+Nxor8lhXt+R/2kb+xwGZF5UgAPlL4b7TO0n+NHWZ/G2juqET
ljfK5VCUr/J8MS0TRl25y6ZBNUMcDBxnNFR9QnTNVG6bLyqGxeIvu1gs+mKEsHmUePHmtINBPSTJ
GbWdRZKyon31sRvHs42b6SxEz17/KPYzjEgiLLLQs/KUhSyOAjbu5wWu218Z3uL0H5Z/YL198nkW
JISX0LxkiH1IryIXOnIXKwsPiPimdJeI6qOBIEoHrM7mKx+Nhnzpo9Gor+p1mXI1xG1JL/ZEy+Ph
AlZaFBigVxoZD729fn23pF/T4SjvlSJ45oVxvmiV7IjzGGmLjIBnHfYZzWxEZRekXDDP/SpdiMcF
v4E+YR/enJ48t9+evLc/4geWquHTIudbG827FHYlF5yz7gVa0c5TCT6WiV6dNOcpc0HGxLOKKUnO
a7kOS566XInnSMKLYDmZsVYP1zkftEyOViYnHc8CL5db6UPtXOODIyGxRlx1GatKOKrReimzsjA3
pCT5M6uvLnMvQ5eIOL6gQh3j71ME+/+NZ4WsvSa6gG9pEsRe4JIwZE0spt/cbecQRm1PURyki4RC
NiFZPjCbUAhJlqFR6AVOa8EleEk8Y44fXII6L5pwfFPqpmayTambhtHHWr3clLU1JSbWIdtJ/E59
YcB3aau0A64Wizb8hx9/k38/LB7X6xVKtbqTOKUReEGCb8RVYMWQ5m6Gv35PaHAVSbXGrOyKJYuz
SK86m5Ba5RSdSCyMJ8wrb7BLxxH9jFn1Kh5qgPr4qOb9HvMSIfWzzWlw7gLfuzG41FWcspy/oq0c
jkJZFUxeC8kV25Ush98zm03LVSazx4uXlV40VjI4fRuLUIwcWBwmNsux40VmB2mKAaBaJTIj8c5G
obgENznFaM/61PD1a7778TYzssBqCsf8Wd4Sucahl+XyUBHl8lDXRbxeD1kV97JZLlebMbBjtygf
Xz1+3GHB9/3TDyf26a8vX3zA2KHI3aKkLmrbhP9jHiHXCOtWFyViTaDBQjy+FJ3zGo5qMAFhY9Fe
x3/oTV76cEmBJHRZUqLfwULTjVnIvZxQBFnCkVZE6Rn3PdF1ydekNkGa5MmXpftEp4qrDwkdDCxt
aPim7Bsmca9LviZbk68JN6cmki92yTt1a6b6UhwvTMnn5REZ0zlMKWHO1oM0Bp/khwcLTHDZ0UvR
iWGcosWAIrhaGepTWMwgCc4mqAyfueZyT/2SMtWlXMdLm4gTkU0YVbcifDsUidm+wKkmYIrOfH1h
HGtfxKqKzI1hoO5wpBOl3Xxlpg5rWBL5ULGw+DLigOABp5RCWR62bQFb43HN7LKERGnAZ+WzqotO
Z9kVw18UR5L4UjNb/sCOXXcxC/ANDPfAFWTp/KjOMpQ+D3I0Wkz5Qmy2oWne1PySx5/ieKn4yt7B
0uIXPM/ut5ZaQL+WYmwQNpNynjIjZ3z5c4GGIAzBwbDNOISW1of0bzxmGeT4dD59+sTnKXDxMybz
QURXy4GITGm3yOq5UkyDocay1P/1WmSzCElwP8Z5dXFvfazr+j96pf+DjC479SOZtDzHlSLMyhKJ
R2ta9IbWDgKvO/8zNX399x+61fR/7oXE7z/80Ug1VJ2ODOoqmqv5OvE0VaG+Yg39oWKMTM2jlnMf
/R9lrCtb+j/6ev+HA5IXC+UPC4ADEnJAQlH7tkWedjcHgkqlJ1RzEqjId9nYqbZyBgPF8WSqDnWi
+tZtGztYQal5JaX2cRE/qJJiCXXgzlkVgmVUh9c/q8WHdEzDiwHydMuOADvFE1ky1JcyNXL6UN7k
JUtl9EbJUmG9fZ1SKerq65RqAVmtVJ59/Lv9zzedTaZCE93D+6xGBQxMvY87HnFgDvuq+iMr6ptM
8iZlINyoDFxRbrW7sl21KxnqbRT7lysWmcI27VsegvZurI8wjs/LH39BPjHW4GQ/W8IX19hwYwHV
59dNnx2nV+1oi2gghvhxYi+jBZ9yjo5iad8zJkdUOXSJpErboXpwXFj9SxVq4vdZ7GFzgNlQQw01
1FBDDTXUUEMNNdRQQw011FBDDTXUUEMNNdRQQw011FBDDTXU0HfRfwE1p8QWAFAAAA==
--Apple-Mail=_3B66D298-FEA1-4A37-ABBE-8A493C140EF6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> 
> Thanks,
> Paolo
> 
> <0001-block-bfq-re-sample-req-service-times-when-possible.patch.gz>
> 
>> Thank you!
>> 
>> Regards,
>> Srivatsa
>> VMware Photon OS


--Apple-Mail=_3B66D298-FEA1-4A37-ABBE-8A493C140EF6--

--Apple-Mail=_D45781B4-9ACB-4EB0-B468-DF882BDE48A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzm1t4ACgkQOAkCLQGo
9oPIqQ//Z5mcV5eOga88TOTnk31AOpAjof6PYkaQf54nUFxWT8vDmOb7PC8Qj96r
uOHZvR1OvbIcg7MY162L7gDu46TWpwSS8HyYtqbE8X/G6ge9e8dxh6YH3ZvRxRXq
8t3hr6Jwewi6bD/qR/ZfVnxDgY8p0lNnY8lzft2lQyEvuS5Jr7JoktkoUQBS4a17
m1rS3qR0PrMDEwgaBscQuXe4aGGOpUqw8RhY6D5OLHAu20CqBdRekL+8kCxIPn20
aUoDRRdMc4PKlW/quCbpKUV5csALG78Se4pKoc9HI4o9pa512WG9oTd/a2TAI3QY
GU5qLHr+sxHZ2U850J78uGi+InJ1gxTXLuAjiSbGMmWZInaEyvplieR4MC/iYZZA
BiOR5JHol0T10oWelaHjIFsEreXE439MupDO6VrAXJfYOVAdgJM2ESSRO4lUrR0t
CZ8GUqFpM4v6qmhfCx4v3N3vuXk5AeFLll1zlf/Sklj5ks4f/UWmtbuUkZUnodA0
BCgsx/Wmkyo8EilDNQa92uZKcLG430csn13D86TqCR3Jda532swPICXk/KyTOqan
I/zLYII50shrgEpWt0EzBkw32cckWKGz1krqs/U5dxy9SqnjjWDKVlB5pQIIfgWO
5tmYt3twzJ935rkfFyqEG3DpVxsffpfX88FtBy6eFPJ/xBeqM/4=
=uowl
-----END PGP SIGNATURE-----

--Apple-Mail=_D45781B4-9ACB-4EB0-B468-DF882BDE48A5--
