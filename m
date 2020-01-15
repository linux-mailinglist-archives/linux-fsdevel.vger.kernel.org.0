Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FA13CFE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgAOWL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 17:11:58 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46447 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgAOWLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:11:55 -0500
Received: by mail-pl1-f178.google.com with SMTP id y8so7402606pll.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mslewm5+SfbCxNU2yFy5UYCpQMf3EmAJSTZ9e3ERDC4=;
        b=zFWJ4tw9NdTE8/RivajUBkzEuxpE/H9cW8bulC4dc9b/pISeLWpKXvAi0OFgbsXh5Z
         BKn1Bqy6JxICbCTLRP74lsy/qux4+NtLSf2cqQfM011MHlcYO5oJIMBfxSnwfDcpFQZ4
         cUUrQ9y4eI2cnQqiU+YlcjIxv+GuQCGvzog55WGU+lOGMD+VdJKjLd2tIlP2RixUA6nR
         5trCjjXXOBIBYeUnNCCJK/GvHrqtbPzkbXqxg2bTCjcJ9GXOV00NWe12rFOTCO33QmyC
         wvz6NSpFcK1RKdCDUrcYEuyri+PeU8QsWgDf2CYY+cL7ST0+5nbTil09Q+PulbBMAf2r
         UgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mslewm5+SfbCxNU2yFy5UYCpQMf3EmAJSTZ9e3ERDC4=;
        b=SJk9ZE+bJtg/yqPP6bd8IoGKLSiXSrpKVB2ZMA5mzIcCYDwUq6sJcRDwm+RsGSTPE8
         QS6xEusWu+T5Cg0yjQ4Fc3kIbUXlu8tLjzkVE28A2ZIpsnBBH/YvCg+zB+xRCoQP08MR
         6gOoiqiAlA52mHgKa1SnL6w2pL2nxfRucZ8XiTIg72piGu7dJy/NeQxSe+4JuQnok4rd
         XdVHh/pqhKqxWxk1DxK5ubmWGcIHq0TTS5UAupAaCE6AJaZgPp9Tw5TYJVEQNNGK+mA9
         3eGeX06f4IcnF/r+RTJLHaHrXo7WLkJmWPI9pNxrqLMXOC5Lh2vMwDN2mEfT7hYR9B9b
         nLwA==
X-Gm-Message-State: APjAAAX5o/DCA48e57XhS1Ncu6kMTuaMvDymoePEfowSeAiRWgZLOUTb
        jHVa08Ki8vG4frc0vhxgrwlqqQ==
X-Google-Smtp-Source: APXvYqxj5dvWG4KwcoWsaQo2mdi9+le/C1B3RPavisKHxw8V4V6qx+4bxdT2MiRz+5asOLuGn/eKgw==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr27989255plt.223.1579126314676;
        Wed, 15 Jan 2020 14:11:54 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id k23sm21025444pgg.7.2020.01.15.14.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 14:11:53 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7233E240-8EE5-4CD1-B8A4-A90925F51A1B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9180B67E-F18A-478C-A1F5-692FAFE1F5AF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Problems with determining data presence by examining extents?
Date:   Wed, 15 Jan 2020 15:11:51 -0700
In-Reply-To: <23762.1579121702@warthog.procyon.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     David Howells <dhowells@redhat.com>
References: <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca>
 <4467.1579020509@warthog.procyon.org.uk>
 <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
 <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
 <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com>
 <20200115133101.GA28583@lst.de> <23762.1579121702@warthog.procyon.org.uk>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_9180B67E-F18A-478C-A1F5-692FAFE1F5AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 15, 2020, at 1:55 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andreas Dilger <adilger@dilger.ca> wrote:
>=20
>> I think what is needed here is an fadvise/ioctl that tells the =
filesystem
>> "don't allocate blocks unless actually written" for that file.
>=20
> Yeah - and it would probably need to find its way onto disk so that =
its effect
> is persistent and visible to out-of-kernel tools.
>=20
> It would also have to say that blocks of zeros shouldn't be optimised =
away.

I don't necessarily see that as a requirement, so long as the filesystem
stores a "block" at that offset, but it could dedupe all zero-filled =
blocks
to the same "zero block".  That still allows saving storage space, while
keeping the semantics of "this block was written into the file" rather =
than
"there is a hole at this offset".

Cheers, Andreas






--Apple-Mail=_9180B67E-F18A-478C-A1F5-692FAFE1F5AF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4fjicACgkQcqXauRfM
H+BxLw//bGPhOXY/3cJ9PneKWUn06Um6NY3nyZUxUJ2M6trfAY9A/EIwnVNilORR
+TN7uAZKVs76niQRqQxdKu+VDhpUOE82MCSAsanpyVGvQr+TpMizhyEoyOqaocva
FqkU24Ip/QamHcrV7w2zF9QuE2b0pI5TrPkd22wlhvV9ZZVFZXXVyxAaTif1ShAK
pse8COxvbF5sGh+Ey4pBAc2y7I06rs0MoR4nBrhCLv9gqVQIzIBA2IEs1YTefdbT
/jaK1a9HEn32rPwiSwM0g2+wJny/+/96RDAunfnrWUSeZBhJLWGpjLdmw8X9Cx7u
/55vlxGqdh9ETjHcKY3NInau59u74y+wRchpSb+NXU+hVb/vcJSISEn1YaI/+lZX
/pflGhxiTbj0i0q60DAzg0w6/W4GpQw5K2jlI23A/2WSP+fMEaFUYum0MgjGBxOT
b+C6QAoMNymAjoPwSwvglVWkOZ1lYbHxLMFUVXkZ1mp+Y8NisgfaSAeQw+58F6vN
HpjVWeXrddFPKe/jKMNrkdeXUh3Md+9K0KWWrPmFnyWEnfyYFSA3QT78O3cDz1K9
1rRNKXrUrWBdalZzgcf3lLfleMnyZ2k3Ctss2bVVtNYNtkam+dV16rXNxx/qxPJJ
krdME9fHBPJBEGeg1TBOd/t4UFLJxqvo+hYLz98k7vDsINvDcMo=
=7Uqr
-----END PGP SIGNATURE-----

--Apple-Mail=_9180B67E-F18A-478C-A1F5-692FAFE1F5AF--
