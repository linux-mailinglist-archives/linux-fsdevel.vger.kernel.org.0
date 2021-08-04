Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96E3E08F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhHDTs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 15:48:58 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com ([98.137.68.206]:42480
        "EHLO sonic304-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236921AbhHDTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1628106523; bh=LNGh9NHIhb5fA7uCyCadJ4uM36CMeld28J3HJ9dwjns=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=CLDhvI13HpJEMniuJqb6+nLsr39dWq/zjg5QBwSM03CZJI4HJpuoIzHSSbJcKQ1q2AlRoZ5YqnLnCS+ce834/AmfOCDEfwy6jxNyBpu7bFzvzDSK1mGsIpI3Kp9oeEo/fv6QDdQo4vEPHxGZJUDh5jqlIgNpIj5aez6R3KemSqTWSr/VslVmfjnuGWb1i9LSJKuZq6aCdwL0CsCFYSo/h6TeAMDGMC3VwppC43Qc/qbzQCW4uQL0NmTSFrhYzbZplwyifdDWEdNriT3l8HYO09q6WEp/otnOY/womgFllOm2f5EnIeI6QyyMZm7nkiG01+aWd82CF5e1jHEmn2ajxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628106523; bh=ezAPH3oF+ePWSWtV7ABJHkMKCQtAWa8f30ZU7dsUQ1e=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=rTp38fxwi6dWBi8uNTD3Q0xSTbYn38faOh2F586vSxtGoLtTEDqGWMBXbE90Zl5dNk9na6BYiuaeQH20YWKcHQG/IWNvBLPpTL3BeO0V1tLmPcNbj1ZoLcHD4pgeqO1te1pFJgDJdvII4A9TLevmXSKgJqEb5wupwbpBcqRH6wsR3BPV2oH5wPEbv3ezt0bFPpMVGKvOKPIKtXo5BhVXOQcMhu6oxasiDmvZwLpbC8/xwo29C2/toe/cGLlE0xvJ9p/FfeDFaWh7kjtLvpxhBgABeqUYI/kG9OGAbsM/gd2/C5LwlpKYO8MS11XXrkU+dBNLRQ6CwSOo54u4zv8uRQ==
X-YMail-OSG: wXcBCvIVM1m9uQstF84zyKIGA_LCrsjroEX274nOn5MOKuIKuekLdqZmOSfxHa.
 f78uIy4.FMsLrDq1Zm89XUtyhoTsL08c8Cp_AxgkgQv_wA5msgWP4KTGmnI5SOXRw.x1DTpUElIS
 Q1BDesYx72WCSvqqb.bTABrHqA0ry30wgKgSAKhoRZ0cFTgGiGVhr7y3fMaHg.yo7r.YcjECipDA
 L.DHqVuonKDnLiRYLXYy6BZs5TSQu_9v7m76C1pC6tV8zb9McUou65zABEiAdqHP9ftjUHy.sm9S
 SR1cNcWpTUlxKfppHifNOLYj3p93YUk7AdtVwGY_5Vyut03wGSJh9vQUti5V4XFR3ISVW54M24v4
 TNmpYa2ePjLBSUJKYlUV1kawRMYOQ3OLkLCAlp7MIKbZALQueKwgOGUyiR_vRg4hOhs1XLHMjHat
 4wJrpeSR6nKVlKZEd9EOgWTXpLAedzOGaa69AB8ZYB0veqPEGRtz3Gi39AnxEOqYuWTFJyZwDiSf
 f6nAw3WAvAEj19O0KBoGYDNcOlbcMx7ZYD.fpA66E45elFh_zh6FqlILKqpdGaZr1I4prLgy1dzt
 H917pBTpFCEPsZzJ51EbJ7BEoMe4IrO39ZK700f710.MU9HKpADJI0klc2gINp5eXxy8BwxWWXgp
 rIKY_LPpJ3frDoagUSJgYasOCvWWiJ6R7ctII5jSozCgcV2nkTl9Mlkr3S54bHaGJSjoVjDyo2cO
 OdAje1sHqtkF.vHVDsTj9mDxOj5VOszkh8cY88Pg8lxyYnc7lnqH2GcKgnMjMMu7GuKGSpy..JMc
 E5tEvbNNGP.xOtG2QObWvgzz9lbgzjsRXcIkzEQRlXP7bcN1FWYLJgALJvYxtgA6Z6w_Zu5xGbvU
 hlrNxrcWyFlYzFZrA6sKnVVXX4po6xiTGSbKQWx1obfO3513Ioky51uyi.ZORz16zLEMMr44VSaG
 YPgBX35u59ZWcPS1PJHKM1Z8Dj28aaD9JSA7OGXbnGiDmHPOYA7uktOI.b5XOCV4KCiNpnrWA8SY
 4.IQxbEJ8i3U9piK0H2V51fPsbu1OnzibBvzc3rqs34Mpu.cwS3v88PFH4x2HLAW9CuBFhKv65h0
 pD13mWmtUH3GDo2wtvlXP3zJo8wRkseIh2LZZ9_RXhzUvvLXT60uvxqFfAXquGpk6q5pT0TltzSC
 p2anQrceT.xB.GEOiDK6wrEUJnlCqdSICq84TK07GiHIpH_OuySCQGTsB_OWs81fwWMGj5YygLvy
 rMD3nC5OgnhpU18YLwkoBy9kuA9Chz9KGVmGFRN1CIlG9Kcezvyd8f2ERFkSINfBZEMZzkfm7jT4
 oPGMw5_ZFJRSLAojgPgILGdHRBCh76k6669pFLbj2dsR5VJ1tgqszpVFy8C4h2ZhiWIo1mNg9NMO
 1zTYcDNhF_PHubqm6HVS1VykWr19LpGAvHG1gCmkYeV1I9Wd_.JVbngd7VsRovFx49Na2ORBdd.k
 BBZZbmMetQJxrdySKwpXIL3t9vvn_gXdYvzJyaucisYRIjYwolZSGa9.T1VsgO1XCP9Ing9cCnDF
 573zymw.rGu9_SP6J.K6RFpf.5HvRn0AOAV6Q98MxjTk0EevQ_SK_rqxi3FfcHdcqSXWlIQnfSjC
 vae2.d.pmVC0oIB9sZOPy7rkpQLo2UP30zvoetK5Wi8fpiSnKcuDfw9S219s_K0o5C8rDvwTysb0
 jf0hwCbacoXmDrIyamaaV9IPTwlZYCteyBhWSGDxZA_H3aYP_WYU4q40MqSI_QptppWbFunLUq1l
 XqJWc7pzJ_RX66FyurILq9gsyQVi2CRXsNfOXDbP4lgA_fbLaffAziCRiK8b_qhF8mZSDUhqqwQp
 Sy.i7bzy0YuVnH29omr6IDdZ9MGQqD9C_e3Gb5twn21z4EyOSdFG9D_rOMLHyIcZ_RPiKs_mQXCj
 GxBAH97g1pHaZpvBcAHladkRBL1od8CH4Si9SrBNxkXJBpsMwburXTNGcZNsmg8J12a2BjcxX8GP
 I4cD7mkEVsqe8F4JBb6XVyfGafwEVHXMKPzDA1AQlA0UISFWop8qzJhJ5vXB.UTE3Fhkf9LOnaL6
 mITg5bp7QXv._cJeIZMcUYrajCfaWX0JiLRKjf.cLX1XkNDANdZdn_RqeFdawPBoF_ORLPZFXC4m
 6eyQ3f7K2d5kIcBK6kO3zDHlJw_KE.iuMrGfEyTT8KiMFR44LNIzSfniDQRkDI3LeM1cKIZPSBeN
 EZIV5FBa6QR9YW1rAcmbKif9L3.TOyvkz.RNYil2LNOgFyjOdRxuRJ6UA7HcfOIyys0_r7kdI2CH
 J95szLl4.FORK7I7FfE75Gwu7gbSKHfvlkgRUYFMTc4SSNW.DTg4oPxJf3_mkePP30gp7N51l_Hb
 qf9oy36ItO_3oe5lkqzUBE.Pi7K2Ti7d49nVFHVo6SeM79Tyc49bisf0QN1lBVaJGvFrex77edV5
 5A.gdWuh74EwGYjBU948wkqUmk2DNPn2A70EyeG5quQMVroGvGf0WCcfLj8sp4iZAObl0X9Vf8nu
 8XpJZRfeJsJcTUvylXM71iDKLLVteSuJyMIDmpaxJ8ZCmvjmo4mTjzTSDn6L6nuFMc25qtEUxDHE
 5RMRfPK3cJNgTS2UZ5VgjhIxjysZ8Y0L5yRSd_mFrezBFvki5eA8GTwXa.ClnNRZUgcPqhITLO.4
 qv.pfV5_N12StjdoDgb_nvzXC_yJVoYyuVdJR3.h4FwBWeC.p6oPXgz8JZ4wGBDzH3ysaWvqtuIv
 D69IxyKJXR.fMyh2fSyaxihqDEdrFIY.o9LqJ_9x6jKPnp7BRKyUbIms2PgzQY1aw0mjbjfa6Sde
 cpyNnx1VvdpyWUifwVuVC5bnktUXEj_DRV.ZrKsmaexgbTM4IPodxK0UyFp81vS3Nwv79HFjC47g
 NDaOPAFguQoDxESuidKXLaR0U_4wslg9hRU2OTQEGaOG0VtgZvMgYRsMO37Myutp_SN7NOiG38og
 udjd.YoTtd464y4419Czn8UdBDfL2SsR0hx0_GEbY52QUi.j3f2pvB9Q0FCwUpp0S7W.V9jgu0qy
 KSscoI40ekYsEw4gmIMzFYbMnC1tBzzidEQk5U.45sS3csmAAQ3toAxPLV8htacqpiCdT8_GgMG0
 xleeiMQ88k97O9gqTAsxBmyTHa5E0sl1C40ynKJkrl7U6elPM_Jt9_3PX9178lA.Yfhi3XaBnllt
 ql_XBJhzcBi4D8PzM1AmmE86_JIe6LGT7icQR.ULFCXbKaiW_OlvU7G82ihwbId9ft3cVLbLDPz0
 ujWD1phtpI2g5n9Sn1ElGXV6gMhzRKPeFdz.QJ_9JimUr_gYvTuWCcIdboqDmkxDKx_64gpJqGqr
 99ffk7odGVb1An.zu0Cf9BfV4G7BVZfOgrtLqNkyvhQTJACVgQIoQsc3PPUuCTwpaevjzZBpPt3E
 qzFO_qQNtOdofvHSkx1CeNR.Td9lwuAi.nUtaoN4GCSAQMzLKRyhs44C5RGvxuXA5nRN4hX1wqRU
 XKkcOGDMM0ZFXQ6FzDlATWDu5_Bk5mO.HukIHl1xUZnklCwnr1eqh_TRVGkZwr2Oo4p6Hc_0.zVC
 U0_QsoHMnEXrolX.0Nslqzz4P08kpmFGPhm4zUSNLyFQVDhjFhwDKkgDNfX.iAXi1lIP1m2iw7TD
 AdnxGvD4pr7PrjJECD4oKlUS4duLFK0iUoeLk0su.RXZYVqHsiXBefDIsLt.pRiADvWiPiPTu7Sv
 Ykiudmt.ss7wU9uVUW.PQqWb_0iQ_Ha8R0xUSp8vFDBOZdUaA10CB51tEBkuiHRwZNP2mN5diXwI
 CzSTpILKUrMCTw7YIEiB_qCcOtNA.mAAvpf0tHUyzIwiNRxigxfRiTUd2AOZDa0.pRxS2zb51uYk
 UUu8PpLUZHTbX
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 4 Aug 2021 19:48:43 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2961fbab5bea3292d10f4f927ac96299;
          Wed, 04 Aug 2021 19:48:40 +0000 (UTC)
Date:   Wed, 04 Aug 2021 15:48:36 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [REGRESSION?] Simultaneous writes to a reader-less, non-full pipe
 can hang
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     acrichton@mozilla.com, Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Kent <raven@themaw.net>
References: <1628086770.5rn8p04n6j.none.ref@localhost>
        <1628086770.5rn8p04n6j.none@localhost>
        <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com>
In-Reply-To: <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1628105897.vb3ko0vb06.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.18749 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Linus Torvalds's message of August 4, 2021 12:31 pm:
> Your program is buggy.
>=20
> On Wed, Aug 4, 2021 at 8:37 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wro=
te:
>>
>>     pipe(pipefd);
>>     printf("init buffer: %d\n", fcntl(pipefd[1], F_GETPIPE_SZ));
>>     printf("new buffer:  %d\n", fcntl(pipefd[1], F_SETPIPE_SZ, 0));
>=20
> Yeah, what did you expect this to do? You said you want a minimal
> buffer, you get a really small buffer.
>=20
> Then you try to write multiple messages to the pipe that you just said
> should have a minimum size.
>=20
> Don't do that then.
>=20
>> /proc/x/stack shows that the remaining thread is hanging at pipe.c:560.
>> It looks like not only there needs to be space in the pipe, but also
>> slots.
>=20
> Correct. The fullness of a pipe is not about whether it has the
> possibility of merging more bytes into an existing not-full slot, but
> about whether it has empty slots left.
>=20
> Part of that is simply the POSIX pipe guarantees - a write of size
> PIPE_BUF or less is guaranteed to be atomic, so it mustn't be split
> among buffers.
>=20
> So a pipe must not be "writable" unless it has space for at least that
> much (think select/poll, which don't know the size of the write).
>=20
> The fact that we might be able to reuse a partially filled buffer for
> smaller writes is simply not relevant to that issue.
>=20
> And yes, we could have different measures of "could write" for
> different writes, but we just don't have or want that complexity.
>=20
> Please don't mess with F_SETPIPE_SZ unless you have a really good
> reason to do so, and actually understand what you are doing.
>=20
> Doing a F_SETPIPE_SZ, 0 basically means "I want the mimimum pipe size
> possible". And that one accepts exactly one write at a time.
>=20
> Of course, the exact semantics are much more complicated than that
> "exactly one write". The pipe write code will optimistically merge
> writes into a previous buffer, which means that depending on the
> pattern of your writes, the exact number of bytes you can write will
> be very different.
>=20
> But that "merge writes into a previous buffer" only appends to the
> buffer - not _reuse_ it - so when each buffer is one page in size,
> what happens is that you can merge up to 4096 bytes worth of writes,
> but then after that the pipe write will want a new buffer - even if
> the old buffer is now empty because of old reads.
>=20
> That's why your test program won't block immediately: both writers
> will actually start out happily doing writes into that one buffer that
> is allocated, but at some point that buffer ends, and it wants to
> allocate a new buffer.
>=20
> But you told it not to allocate more buffers, and the old buffer is
> never completely empty because your readers never read _everythign_,
> so it will hang, waiting for you to empty the one minimal buffer it
> allocated. And that will never happen.
>=20
> There's a very real reason why we do *not* by default say "pipes can
> only ever use only one buffer".
>=20
> I don't think this is a regression, but if you have an actual
> application - not a test program - that does crazy things like this
> and used to work (I'm not sure it has ever worked, though), we can
> look into making it work again.
>=20
> That said, I suspect the way to make it work is to just say "the
> minimum pipe size is two slots" rather than change the "we want at
> least one empty slot". Exactly because of that whole "look, we must
> not consider a pipe that doesn't have a slot writable".
>=20
> Because clearly people don't understand how subtle F_SETPIPE_SZ is.
> It's not really a "byte count", even though that is how it's
> expressed.
>=20
>                    Linus
>=20

I agree that if this only affects programs which intentionally adjust=20
the pipe buffer size, then it is not a huge issue. The problem,=20
admittedly buried very close to the bottom of my email, is that the=20
kernel will silently provide one-page pipe buffers if the user has=20
exceeded 16384 (by default) pipe buffer pages allocated. Try this=20
slightly more complicated program:

#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

static int pipefd[2];

void *thread_start(void *arg) {
    char buf[1];
    int i;
    for (i =3D 0; i < 1000000; i++) {
        read(pipefd[0], buf, sizeof(buf));
        if (write(pipefd[1], buf, sizeof(buf)) =3D=3D -1)
            break;
    }
    printf("done %d\n", i);
    return NULL;
}

int main() {
    signal(SIGPIPE, SIG_IGN);
    // pretend there are a very large number of make processes running
    for (int i =3D 0; i < 1025; i++)
    {
        pipe(pipefd);
        write(pipefd[1], "aa", 2);
    }
    printf("%d %d\n", pipefd[0], pipefd[1]);
    printf("init buffer: %d\n", fcntl(pipefd[1], F_GETPIPE_SZ));
    //printf("new buffer:  %d\n", fcntl(pipefd[1], F_SETPIPE_SZ, 0));
    pthread_t thread1, thread2;
    pthread_create(&thread1, NULL, thread_start, NULL);
    pthread_create(&thread2, NULL, thread_start, NULL);
    sleep(3);
    close(pipefd[0]);
    close(pipefd[1]);
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
}

You may need to raise your RLIMIT_NOFILE before running the program.

With default settings (fs.pipe-user-pages-soft =3D 16384) the init buffer=20
will be 4096, no mangling required. I think this could be probably be=20
solved if the kernel instead reduced over-quota pipes to two pages=20
instead of one page. If someone wants to set a one-page pipe buffer,=20
then they can suffer the consequences, but the kernel shouldn't silently=20
hand people that footgun.

Regards,
Alex.
